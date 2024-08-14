# WordPress Bitnami on AWS Lightsail Migrate and Update Tool

## Table of Contents

- [Overview](#overview)
- [Which Scope Gets Automated?](#which-scope-gets-automated)
  - [Automated Tasks](#automated-tasks)
  - [Manual Tasks Remaining](#manual-tasks-remaining)
- [Folder Structure Tool](#folder-structure-tool)
- [Terraform Modules Overview](#terraform-modules)
- [Configuration in `terraform.tfvars`](#configuration-in-terraformtfvars-file)
- [Prerequisites](#prerequisites)
- [Deployment](#deployment)
- [Logging](#logging)
- [Aftermath](#aftermath)

## Overview

Maintaining an up-to-date WordPress installation on AWS Lightsail with the WordPress Bitnami image can be challenging due to the limitations of updating the underlying LAMP components (Linux, Apache, MySQL/MariaDB, PHP) directly on the Lightsail instance. The WordPress image packaged by Bitnami bundles these components, which are adapted to each other and optimized for WordPress, making in-place updates infeasible. As a result, it becomes necessary to spin up a new AWS Lightsail instance with the latest WordPress Bitnami image and migrate the WordPress content from the old instance to the new one.

![Problem GIF](/doc/img/wordpress-on-lightsail.gif)

This tool automates this process, reducing the manual steps required to achieve a fully updated and migrated WordPress site.
Using Terraform, it handles:

- the creation of a new Lightsail WordPress Bitnami instance
- the WordPress content migration
- optional WordPress core, plugins, and themes updates
- optional creation of an external MySQL Lightsail database for WordPress

## Which scope gets automated with this tool?

Importantly, your existing Lightsail instance is neither deleted nor taken out of service by this tool. In this respect the tool establishes only an SSH connection to the old instance and uses `rsync` and `wp-cli` to migrate the WordPress content and the database dump. It is the administrator's responsibility to manually decommission the old instance after successful migration.

### Automated Tasks

| **Automated Task**                                                       | **Description**                                                                                                                                                                                                      |
| ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Provisioning New WordPress Bitnami Lightsail Instance**                | Creates a new AWS Lightsail instance using the latest WordPress Bitnami image.                                                                                                                                       |
| **Optional: Provisioning an External MySQL Lightsail Database Instance** | Configures an external MySQL Lightsail database instead of using the internal MariaDB on the Bitnami Lightsail instance. This involves provisioning a new Lightsail database instance with the latest MySQL version. |
| **WordPress Content Migration**                                          | Transfers the entire WordPress installation (including wp-content, wp-admin, wp-include, etc.) from the old WordPress Bitnami instance to the new one using `rsync` over an SSH connection.                          |
| **WordPress Database Migration**                                         | Transfers the WordPress database dump from the old WordPress Bitnami instance to the new one using `wp-cli`.                                                                                                         |
| **Optional: WordPress Core, Plugins, and Themes Updates**                | Optionally updates the WordPress core, all installed plugins, and themes to their latest versions once the migration is complete.                                                                                    |
| **Logging**                                                              | Creates three log files documenting the entire configuration, migration, and update process.                                                                                                                         |

### Manual Tasks Remaining

| **Manual Task**                | **Description**                                                                                                                                                                                                                                                                                                  |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Functionality Verification** | After the migration and update process, a manual check is necessary to ensure that the WordPress site functions as expected. This includes testing site features, plugin functionalities, and theme layouts.                                                                                                     |
| **Traffic Management**         | Domain, DNS, Load Balancer, and SSL/TLS configurations are not handled by this tool. You must manually update DNS records or Load Balancer settings to point to the new instance IP address. This may involve reconfiguring bncert or updating the Lightsail Load Balancer to point to the new Bitnami instance. |
| **Decommission Old Instance**  | After verifying the new instance, the old Lightsail instance must be manually terminated.                                                                                                                                                                                                                        |

Below are two example architectures. These are intended for illustrative purposes only and serve as example use cases where this tool could help to update the Lightsail WordPress Bitnami infrastructure.

![Example Use Cases](/doc/img/wp-patch-update.png)

## Folder Structure Tool

```bash
wordpress-bitnami-lightsail-patch-migrate-update
├── README.md
├── doc
│   └── prerequisites
│       ├── aws-cli-installation.md
│       ├── aws-credentials-configuration.md
│       ├── aws-programatic-access.gif
│       ├── create-lightsail-key-pair.gif
│       ├── ssh-agent-forwarding.md
│       ├── ssh-key-pairs.md
│       ├── terraform-installation.md
│       └── wp-patch-update.png
├── logs
│   ├── configure.log
│   ├── migrate.log
│   └── update.log
└── terraform
    ├── main.tf
    ├── modules
    │   ├── bitnami-lightsail-instance
    │   │   ├── main.tf
    │   │   └── variables.tf
    │   ├── external-lightsail-mysql-db
    │   │   ├── main.tf
    │   │   └── variables.tf
    │   ├── migration
    │   │   ├── main.tf
    │   │   └── variables.tf
    │   └── wordpress-update
    │       ├── main.tf
    │       └── variables.tf
    ├── terraform.tfvars
    ├── userdata
    │   ├── migrate_wordpress.sh.tftpl
    │   ├── wp_config.sh.tftpl
    │   └── wp_update.sh.tftpl
    └── variables.tf
```

## Terraform Modules

This Terraform configuration is structured using modules to separate concerns and make the deployment process more modular and reusable. Below is a brief description of each module and its purpose:

### Module: bitnami-lightsail-instance

This module provisions a new AWS Lightsail instance using the latest WordPress (from Bitnami) image. It handles the following:

**Instance Creation**: Launches a new WordPress Lightsail instance (pre-packaged by Bitnami):

- Configs: Associates the specified SSH key pair with the new instance and sets up your instance according the specified bundle_id.
- Snapshots: Enables auto snapshots on a daily basis (00:00 UTC) for your new WordPress Lightsail instance
- wp-config.php: Configures the new WordPress instance with the necessary settings, including database credentials (optional) and table prefixes (optional).

### Modules: external-lightsail-mysql-db

This module is optional and used only if you choose to configure an external MySQL database instead of using the internal MariaDB on the Wordpress Bitnami Lightsail instance. It handles:

- **Database Provisioning**: Creates a new Lightsail MySQL database instance with the specified resource bundle.
- **Database Configuration**: Sets up the new database with the provided name and username.
- **Password Management**: Generates a secure password for the database and outputs it for use in the WordPress configuration.

### Module: migration

This module manages the migration of WordPress content and database from the old Wordpress Bitnami Lightsail instance to the new one. It handles:

- **Content Migration**: Uses `rsync` over SSH to securely transfer the `wp-content`, `wp-admin`, and `wp-includes` directories from the old instance to the new one.
- **Database Migration**: Exports the WordPress database from the old instance and imports it into the new instance using `wp-cli`.
- **SSH Connection Management**: Establishes secure SSH connections to both the old and new instances for the migration process.

### Module: wordpress-update

This module is responsible for updating WordPress components on the new instance after the migration is complete. It handles:

- **Core Update**: Optionally updates the WordPress core to the latest version.
- **Plugin Update**: Optionally updates all installed WordPress plugins to their latest versions.
- **Theme Update**: Optionally updates all installed WordPress themes to their latest versions.
- **Logging**: Captures detailed logs of the update process and retrieves them to your local machine for review.

Each module is designed to perform a specific task in the overall migration and update process, making the configuration more modular, maintainable, and easier to customize.

## Configuration in `terraform.tfvars` file

In this section, you will configure the necessary variables for deploying your new WordPress Bitnami Lightsail instance, migrating and updating your WordPress page using Terraform. The configuration needs to be made in the `terraform.tfvars` file, which defines all required and optional settings. Below is a breakdown of what you need to pay attention to. It is commented in more detail in the file itself.

### 1. Required Configurations

These configurations are mandatory for the deployment process. You need to specify the AWS region, the IPv4 address of the old WordPress instance, SSH keys for both old and new instances, and the bundle ID for the new WordPress Bitnami Lightsail instance.

- **AWS Region**: Specify the region where your Lightsail resources will be deployed.
- **Environment**: Set the environment for your deployment e.g., dev, stage, prod (is used in the name of the Lightsail instance "wordpress-<env>-<timestamp>").
- **Old WordPress Instance IP**: Provide the IP address of your current WordPress instance.
- **SSH Key Pairs**: It's recommended to generate a new key pair for the new instance via the AWS Lightsail Management Console (The detailed instructions for this are covered in Prerequisites). You may use the same key pair as the old instance, but this is not recommended for security reasons.
- **Bundle ID for New Instance**: Choose a bundle ID that matches the resource requirements for your new instance.

### 2. WordPress Configurations

These settings are related to the WordPress-specific configurations on your new instance.

- **Table Prefix**: Specify the WordPress table prefix. If your old instance uses a custom prefix, update this variable accordingly.
- **Update WordPress Core, Plugins, and Themes**: These options allow you to control whether the core, plugins, and themes should be updated post-migration. The default behavior is to update all.

### 3. Tags

Use this section to tag your AWS Lightsail resources. Tags in AWS help you identify and manage your resources more effectively.

- **Name, Github, Owner**: Customize these tags as needed. They will be applied to all created resources.

### 4. Path Configurations

These paths point to the `wp-content` folder and `wp-config.php` file on both the old and new instances.

- **Old and New WordPress Path**: Default is `/bitnami/wordpress`. Modify these only if you have a custom setup.

### 5. Optional Database Configuration

This section is relevant if you choose to use an external MySQL Lightsail database instead of the built-in MariaDB.

- **Use External Database**: Set this to `true` if you wish to use an external database.
- **Database Name and Username**: Customize these as needed for your external database (pw gets auto generated).
- **Database Bundle ID**: Similar to the instance bundle ID, this allows you to specify the resource requirements for your database instance.

## Prerequisites

Before using this tool, ensure you have the following prerequisites (go through the links for detailed documentation for MacOS/Windows):

- **Terraform Installed**: [Install Terraform](doc/prerequisites/terraform-installation.md)
- **AWS CLI Installed**: [Install AWS CLI](doc/prerequisites/aws-cli-installation.md)
- **AWS Credentials**: [Create and Configure AWS Credentials](doc/prerequisites/aws-credentials-configuration.md)
- **SSH Key Pairs**: [Create & Download SSH key pairs the old and new Lightsail instances](doc/prerequisites/ssh-key-pairs.md)
- **SSH Agent Forwarding enabled and key(s) added**: [Configure SSH Agent Forwarding](doc/prerequisites/ssh-agent-forwarding.md)

## Deployment

## Deployment

To deploy the migration and update process for your Bitnami WordPress instance on AWS Lightsail, follow the steps below. Using an IDE can be beneficial for managing your configuration files and running commands directly from an integrated terminal.

### 1. **Clone the Repository**

First, clone the repository containing the Terraform configuration to your local machine:

```bash
git clone https://github.com/jexnator/wordpress-bitnami-lightsail-patch-migrate-update.git
```

Once cloned, navigate into the `terraform` directory:

```bash
cd /terraform
```

### 2. **Initialize Terraform**

Before running any Terraform commands, you need to initialize the working directory. This step downloads the necessary provider plugins and sets up the backend:

```bash
terraform init
```

### 3. **Configure Terraform Variables**

Ensure that all necessary configurations have been specified in the `terraform.tfvars` file. This includes AWS region, SSH key paths, and any optional configurations like database settings. Refer to the `terraform.tfvars` section for detailed guidance.

### 4. **Validate the Configuration**

To check if your configuration is syntactically valid, run:

```bash
terraform validate
```

This command ensures that your Terraform files are correctly configured and ready for deployment.

### 5. **Plan the Deployment**

The `terraform plan` command creates an execution plan, allowing you to preview the changes that will be made:

```bash
terraform plan
```

This step is crucial for understanding the resources that Terraform will create, modify, or destroy.

### 6. **Apply the Configuration**

Finally, apply the configuration to deploy the new WordPress instance, migrate content, and update WordPress components:

```bash
terraform apply --auto-approve
```

During the deployment, Terraform will output the progress in the terminal, including any remote execution commands and their results. Once the deployment is complete, the public IP address of the new Bitnami WordPress instance will be displayed in the terminal output.

You can then copy this IP address into your browser to verify that the site has been successfully migrated and is functioning as expected.

## Logging

Throughout the deployment process, the tool generates detailed logs for monitoring and troubleshooting purposes. These logs are stored in the `logs` folder within the project directory. The following log files are created during deployment:

- **configure.log**: Captures all events related to the initial configuration of the new WordPress instance.
- **migrate.log**: Records details of the content migration process from the old instance to the new one.
- **update.log**: Logs all actions related to WordPress core, plugins, and themes updates.

## Aftermath

If you plan to use this tool multiple times or need to re-run the migration, patching, and updating process after some time, it's important to reset the Terraform state. This ensures that Terraform will not try to reconcile the existing infrastructure with the desired state, which could lead to unexpected behavior.

To reset the state and prepare for a fresh deployment, navigate to the Terraform directory and run the following command:

```bash
rm -r terraform.tfstate terraform.tfstate.backup .terraform .terraform.lock.hcl && terraform init -reconfigure
```

This command deletes the current Terraform state files and reinitializes the Terraform environment, allowing you to start the process anew without any residual data from previous runs.

### Final Considerations

As a final step after a successful deployment, it may be prudent to delete the IAM user created for this process to minimize security risks. Ensure that the private keys used during the process are stored securely, and consider deleting them from your local machine after the deployment to stay safe.
