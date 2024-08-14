## `terraform.tfvars` file

In this section, you will configure the necessary variables for deploying your new WordPress Bitnami Lightsail instance, migrating and updating your WordPress page using Terraform. The configuration needs to be made in the `terraform.tfvars` file, which defines all required and optional settings. Below is a breakdown of what you need to pay attention to. It is commented in more detail in the file itself.

### 1. Required Configurations

These configurations are mandatory for the deployment process. You need to specify the AWS region, the IPv4 address of the old WordPress instance, SSH keys for both old and new instances, and the bundle ID for the new Bitnami WordPress Lightsail instance.

- **AWS Region**: Specify the region where your Lightsail resources will be deployed.
- **Environment**: Set the environment for your deployment e.g., dev, stage, prod (is used in the name of the Lightsail instance "wordpress-<env>-<timestamp>").
- **Old WordPress Instance IP**: Provide the IP address of your current WordPress instance.
- **SSH Key Pairs**: It's recommended to generate a new key pair for the new instance via the AWS Lightsail Management Console (No worries! The detailed instructions for this are covered in Prerequisites). You may use the same key pair as the old instance, but this is not recommended for security reasons.
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
