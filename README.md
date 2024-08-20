# WordPress Bitnami on AWS Lightsail Migrate and Update Tool

## ToC

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

# Overview

Maintaining an up-to-date WordPress installation on AWS Lightsail with the WordPress Bitnami image can be challenging due to the limitations of updating the underlying LAMP components (Linux, Apache, MySQL/MariaDB, PHP) directly on the Lightsail instance. The WordPress image packaged by Bitnami bundles these components, which are adapted to each other and optimized for WordPress, making in-place updates infeasible. As a result, it becomes necessary to spin up a new AWS Lightsail instance with the latest WordPress Bitnami image and migrate the WordPress content from the old instance to the new one.

![Problem GIF](/doc/img/wordpress-on-lightsail.gif)

This tool automates this process, reducing the manual steps required to achieve a fully updated and migrated WordPress site.
Using Terraform, it handles:

- the creation of a new Lightsail WordPress Bitnami instance
- the WordPress content migration
- optional WordPress core, plugins, and themes updates
- optional creation of an external MySQL Lightsail database for WordPress

# Which scope gets automated with this tool?

Importantly, your existing Lightsail instance is neither deleted nor taken out of service by this tool. In this respect the tool establishes only an SSH connection to the old instance and uses `rsync` and `wp-cli` to migrate the WordPress content and the database dump. It is the administrator's responsibility to manually decommission the old instance after successful migration.

## Automated Tasks

| **Automated Task**                                                       | **Description**                                                                                                                                                                                                      |
| ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Provisioning New WordPress Bitnami Lightsail Instance**                | Creates a new AWS Lightsail instance using the latest WordPress Bitnami image.                                                                                                                                       |
| **Optional: Provisioning an External MySQL Lightsail Database Instance** | Configures an external MySQL Lightsail database instead of using the internal MariaDB on the Bitnami Lightsail instance. This involves provisioning a new Lightsail database instance with the latest MySQL version. |
| **WordPress Content Migration**                                          | Transfers the entire WordPress installation (including wp-content, wp-admin, wp-include, etc.) from the old WordPress Bitnami instance to the new one using `rsync` over an SSH connection.                          |
| **WordPress Database Migration**                                         | Transfers the WordPress database dump from the old WordPress Bitnami instance to the new one using `wp-cli`.                                                                                                         |
| **Optional: WordPress Core, Plugins, and Themes Updates**                | Optionally updates the WordPress core, all installed plugins, and themes to their latest versions using `wp-cli` (once the migration is complete).                                                                   |
| **Logging**                                                              | Creates three log files documenting the entire configuration, migration, and update process.                                                                                                                         |

## Manual Tasks Remaining

| **Manual Task**                | **Description**                                                                                                                                                                                                                                                                                                  |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Functionality Verification** | After the migration and update process, a manual check is necessary to ensure that the WordPress site functions as expected. This includes testing site features, plugin functionalities, and theme layouts.                                                                                                     |
| **Traffic Management**         | Domain, DNS, Load Balancer, and SSL/TLS configurations are not handled by this tool. You must manually update DNS records or Load Balancer settings to point to the new instance IP address. This may involve reconfiguring bncert or updating the Lightsail Load Balancer to point to the new Bitnami instance. |
| **Decommission Old Instance**  | After verifying the new instance, the old Lightsail instance must be manually terminated.                                                                                                                                                                                                                        |

Below are two example architectures. These are intended for illustrative purposes only and serve as example use cases where this tool could help to update the Lightsail WordPress Bitnami infrastructure.

![Example Use Cases](/doc/img/wp-patch-update.png)

# Folder Structure Tool

```bash
bitnami-wordpress-lightsail-patch-migrate-update
├── README.md
├── doc
│   ├── configuration
│   │   └── tf-configuration.md
│   ├── img
│   │   ├── aws-programatic-access.gif
│   │   ├── create-lightsail-key-pair.gif
│   │   ├── wordpress-on-lightsail.gif
│   │   └── wp-patch-update.png
│   ├── modules
│   │   └── modules.md
│   └── prerequisites
│       ├── aws-cli-installation.md
│       ├── aws-credentials-configuration.md
│       ├── ssh-agent-forwarding.md
│       ├── ssh-key-pairs.md
│       └── terraform-installation.md
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

# Terraform Modules

This Terraform configuration is structured using 4 modules to separate concerns and make the deployment process more modular and reusable.

- Module: bitnami-lightsail-instance
- Modules: external-lightsail-mysql-db
- Module: migration
- Module: wordpress-update

For details on what each module does, refer to the [Module Details](doc/modules/modules.md).

# Configuration in `terraform.tfvars` file

In this section, you will configure the necessary variables for deploying your new WordPress Bitnami Lightsail instance, migrating, and updating your WordPress site using Terraform. The configuration needs to be made in the `terraform.tfvars` file, which defines all required and optional settings.

Therefore read through the steps in the [Terraform Configuration Guide](doc/configuration/tf-configuration.md) and consider the comments in the `terraform.tfvars` file itself.

# Prerequisites

Before using this tool, ensure you have the following prerequisites (go through the links for detailed documentation for MacOS/Windows):

- **Terraform Installed**: [Install Terraform](doc/prerequisites/terraform-installation.md)
- **AWS CLI Installed**: [Install AWS CLI](doc/prerequisites/aws-cli-installation.md)
- **AWS Credentials**: [Create and Configure AWS Credentials](doc/prerequisites/aws-credentials-configuration.md)
- **SSH Key Pairs**: [Create & Download SSH key pairs for the old and new Lightsail instances](doc/prerequisites/ssh-key-pairs.md)
- **SSH Agent Forwarding enabled and key(s) added**: [Configure SSH Agent Forwarding](doc/prerequisites/ssh-agent-forwarding.md)

# Prerequisites

This tool can be used on both macOS and Windows. However, on Windows, the SSH agent integration with Terraform is limited. For full functionality, including proper SSH agent forwarding, Windows users need to use WSL (Windows Subsystem for Linux) for the deployment.

Before using this tool, ensure you have the following prerequisites (go through the links for detailed documentation for macOS/Windows):

- **WSL installed if on Windows**: [Install WSL](doc/prerequisites/wsl-installation.md)
- **Terraform Installed**: [Install Terraform](doc/prerequisites/terraform-installation.md)
- **AWS CLI Installed**: [Install AWS CLI](doc/prerequisites/aws-cli-installation.md)
- **AWS Credentials**: [Create and Configure AWS Credentials](doc/prerequisites/aws-credentials-configuration.md)
- **SSH Key Pairs**: [Create & Download SSH key pairs for the old and new Lightsail instances](doc/prerequisites/ssh-key-pairs.md)

# Deployment

To deploy the migration and update process for your Bitnami WordPress instance on AWS Lightsail, follow the steps below. Using an IDE can be beneficial for managing your configuration files and running commands directly from an integrated terminal.

Before deployment, ensure that all prerequisites have been successfully completed.

## **Windows Users only**

1. **Open PowerShell as Administrator**:

   - Press `Windows Key + X`, then select **Terminal** to open PowerShell.

2. **Start WSL**:

   - Inside the PowerShell terminal, start WSL by entering the following command:

   ```powershell
   wsl
   ```

## 1. **Clone the Repository**

First, clone the repository containing the Terraform configuration to your local machine:

```bash
git clone https://github.com/jexnator/wordpress-bitnami-lightsail-patch-migrate-update.git
```

Once cloned, navigate into the `terraform` directory:

```bash
cd wordpress-bitnami-lightsail-patch-migrate-update/terraform
```

## 2. **Initialize Terraform**

Before running any Terraform commands, you need to initialize the working directory. This step downloads the necessary provider plugins and sets up the backend:

```bash
terraform init
```

## 3. **Add your private key(s) to the SSH agent**

- First, start the SSH agent:

  ```bash
  eval "$(ssh-agent -s)"
  ```

- Then, add the private key(s) for both the old and new WordPress Bitnami Lightsail instances to the SSH agent to enable forwarding (Consider using a new key for your new instance):

  ```bash
  ssh-add /path/to/old-instance-private-key.pem
  ssh-add /path/to/new-instance-private-key.pem
  ```

## 4. **Configure Terraform Variables**

Ensure that all necessary configurations have been specified in the `terraform.tfvars` file. This includes AWS region, SSH key paths, and any optional configurations like database settings. See [here](doc/configuration/tf-configuration.md).

Also, make sure that SSH Agent forwarding is configured and that the private keys for both the old and new Lightsail instances have been added to the SSH agent using `ssh-add /path/to/key.pem`. See [here](/doc/prerequisites/ssh-agent-forwarding.md).

## 5. **Validate the Configuration**

To check if your configuration is syntactically valid, run:

```bash
terraform validate
```

This command ensures that your Terraform files are correctly configured and ready for deployment.

## 6. **Plan the Deployment**

The `terraform plan` command creates an execution plan, allowing you to preview the changes that will be made:

```bash
terraform plan
```

This step is crucial for understanding the resources that Terraform will create, modify, or destroy.

## 7. **Apply the Configuration**

Finally, apply the configuration to deploy the new WordPress instance, migrate content, and update WordPress components:

```bash
terraform apply --auto-approve
```

During the deployment, Terraform will output the progress in the terminal, including any remote execution commands and their results. Once the deployment is complete, the public IP address of the new Bitnami WordPress instance will be displayed in the terminal output.

You can then copy this IP address into your browser to verify that the site has been successfully migrated and is functioning as expected.

If you are satisfied with the migration, you need to manually update your DNS records to point to the new instance IP address or reconfigure SSL/TLS certificates as needed. For instance, you might need to update bncert or modify the Lightsail Load Balancer settings to direct traffic to the new Bitnami instance.

Additionally, after verifying the new instance is working as expected, the old Lightsail instance must be manually decommissioned.

# Logging

Throughout the deployment process, the tool generates detailed logs for monitoring and troubleshooting purposes. These logs are stored in the `logs` folder within the project directory. The following log files are created during deployment:

- **configure.log**: Captures all events related to the initial configuration of the new WordPress instance.
- **migrate.log**: Records details of the content migration process from the old instance to the new one.
- **update.log**: Logs all actions related to WordPress core, plugins, and themes updates.

# Aftermath

If you plan to use this tool multiple times or need to re-run the migration, patching, and updating process after some time, it's important to reset the Terraform state. This ensures that Terraform will not try to reconcile the existing infrastructure with the desired state.

To reset the state and prepare for a fresh deployment, navigate to the Terraform directory and run the following command:

```bash
rm -r terraform.tfstate terraform.tfstate.backup .terraform .terraform.lock.hcl && terraform init -reconfigure
```

This command deletes the current Terraform state files and reinitializes the Terraform environment, allowing you to start the process anew without any residual data from previous runs.

## Final Considerations

As a final step after a successful deployment, it may be prudent to delete the IAM user created for this process to minimize security risks. Ensure that the private keys used during the process are stored securely, and consider deleting them from your local machine after the deployment to stay safe.
