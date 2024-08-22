//***********************************************************
// terraform.tfvars
//
// This file contains the global variables required in the 
// Terraform configuration.
//***********************************************************

# ------------------------------------------------------------------------------------------
# 1. REQUIRED CONFIGURATIONS
# These configurations are mandatory and need to be specified for successful deployment.
# ------------------------------------------------------------------------------------------

# AWS Lightsail Region
# Specify the AWS region where your resources will be deployed.
region = "xx-xxxx-x" # Example: "eu-central-1"

# Environment
# Set the environment for your deployment (e.g., dev, stage, prod).
env = "prod" # Default: "prod"

# IPv4 Address of the Old WordPress Instance
# Provide the IP address of the existing WordPress instance that you want to migrate from.
old_wordpress_instance_ip = "xxx.xxx.xxx.xxx" # Example: "198.51.100.0"

# Key Pair Name for the New Instance
# Specify the name of the key pair to be used for the new WordPress instance (<key_pair_name> without ".pem")
key_pair_name_new_instance = "key_pair_name" # Example: "new_instance_key_pair"

# SSH Private Key Path for the Old Instance
# Provide the file path to the SSH private key corresponding to the old WordPress instance.
# Example: "/local/path/to/old_instance_key.pem"
ssh_key_path_old_instance = "/local/path/to/old_instance_key.pem"

# SSH Private Key Path for the New Instance
# Provide the file path to the SSH private key corresponding to the new WordPress instance.
# Example: "/local/path/to/new_instance_key.pem"
ssh_key_path_new_instance = "/local/path/to/new_instance_key.pem"

# Bundle ID for the New Bitnami Lightsail Instance
# Specify the bundle ID for provisioning the new instance based on your resource needs.
# You can get the available bundle IDs using the following AWS CLI command:
# aws lightsail get-bundles --region <your-region> --query \
#  "bundles[?contains(supportedPlatforms, 'LINUX_UNIX')]" --output table
bundle_id_bitnami_instance = "xxxxx_y_y" # Ex.: "medium_3_0" -> 4 GB RAM, 2 vCPUs, 80 GB SSD

# ------------------------------------------------------------------------------------------
# 2. WORDPRESS CONFIGURATIONS
# These settings are related to WordPress-specific configurations.
# ------------------------------------------------------------------------------------------

# WordPress Table Prefix
# Specify the table prefix for WordPress to organize its SQL database tables.
db_wp_table_prefix = "wp_" # Default: is "wp_". Change if a custom prefix is used

# Update WordPress Core
# Determine whether the WordPress core should be updated after the migration.
update_wp_core = true # Default is true. Set to false to skip wp core update.

# Update WordPress Plugins
# Determine whether all WordPress plugins should be updated after the migration.
update_wp_plugins = true # Default is true. Set to false to skip plugin updates.

# Update WordPress Themes
# Determine whether all WordPress themes should be updated after the migration.
update_wp_themes = true # Default is true. Set to false to skip theme updates.

# ------------------------------------------------------------------------------------------
# 3. TAGS
# Tag your AWS Lightsail resources by serveral keys and values to better identify them.
# (Can be personalised by adding or removing keys and values within tags = {})
# ------------------------------------------------------------------------------------------

tags = {
  Name   = "bitnami-wordpress"
  Github = "https://github.com/JEX-98/bitnami-wordpress-lightsail-patch-migrate-update"
  Owner  = "Chuck Norris"
}

# ------------------------------------------------------------------------------------------
# 4. PATH CONFIGURATIONS
# Paths to original (not symlinked) wp-content folder & wp-config.php file on the old
# and new instance.
# (*DO NOT TOUCH THESE VARIABLES IF YOU YOU HAVE NOT CUSTOMISED ANYTHING IN THIS RESPECT*)
# ------------------------------------------------------------------------------------------

# Old WordPress Path
# Specify the path to the wp-content folder and wp-config.php file on the old instance.
old_wp_path = "/bitnami/wordpress" # Default: "/bitnami/wordpress"

# New WordPress Path
# Specify the path to the wp-content folder and wp-config.php file on the new instance.
new_wp_path = "/bitnami/wordpress" # Default: "/bitnami/wordpress"

# ------------------------------------------------------------------------------------------
# 5. OPTIONAL DATABASE CONFIGURATION
# These settings apply if you opt to use an external MySQL Lightsail database instead
# of the internal provided MariaDB on the Bitnami Lightsail instance.
# Standard Approach: Using MariaDB on Bitnami Lightsail instance.
# (*DO NOT TOUCH THESE VARIABLES IF YOU ARE FOLLOWING THE STANDARD APPROACH*)
# ------------------------------------------------------------------------------------------

# Use External Database
# Set to true if you wish to use an external MySQL database instead of the built-in MariaDB.
use_external_db = false # Default is false. Set to true to enable external database usage.

# Database Name
# The name of the database to be created or used in the external MySQL database instance.
db_name_new = "dblive" # Default: "dblive"

# Database Username
# The username to access the new database.
db_username_new = "dbmasteruser" # Default: "dbmasteruser"

# Database Bundle ID
# Specify the bundle ID for the external MySQL database instance based on your ressource
# needs. You can get the available database bundle IDs using the following AWS CLI command:
# aws lightsail get-relational-database-bundles --region <your-region> --output table
bundle_id_mysql_db = "xxxxx_y_y" # Example: "micro_2_0" -> 1 GB RAM, 2 vCPUs, 40 GB SSD

# ------------------------------------------------------------------------------------------
# END OF CONFIGURATION
# ------------------------------------------------------------------------------------------
