//***********************************************************
// variables.tf
//
// This file contains the global variables required in the 
// Terraform configuration.
//***********************************************************

variable "region" {
  description = "AWS Lightsail region"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
}

variable "old_wordpress_instance_ip" {
  description = "IP of the old wordpress instance which needs to be replaced"
  type        = string
}

variable "key_pair_name_new_instance" {
  description = "Name of the key pair for the new instance (<name>.pem)"
  type        = string
}

variable "ssh_key_path_old_instance" {
  description = "Path to the SSH private key for the old instance"
  type        = string
}

variable "ssh_key_path_new_instance" {
  description = "Path to the SSH private key for the new instance"
  type        = string
}

variable "bundle_id_bitnami_instance" {
  description = <<-EOT
  Bundle ID for the new Bitnami Lightsail instance.
  You can get the available bundle IDs using the following AWS CLI command:
  aws lightsail get-bundles --region <your-region> --query "bundles[?contains(supportedPlatforms, 'LINUX_UNIX')]" --output table
  EOT

  type = string
}

variable "db_wp_table_prefix" {
  description = "The (mariadb/mysql) table prefix for WordPress (default, if not customised, is 'wp_')"
  type        = string
}

variable "update_wp_core" {
  description = "Whether to update WordPress core"
  type        = bool
}

variable "update_wp_plugins" {
  description = "Whether to update WordPress plugins"
  type        = bool
}

variable "update_wp_themes" {
  description = "Whether to update WordPress themes"
  type        = bool
}

variable "old_wp_path" {
  description = "Path to the wp-content folder and wp-config.php file on the old Bitnami WordPress instance (typically located at /bitnami/wordpress)."
  type        = string
}

variable "new_wp_path" {
  description = "Path to the wp-content folder and wp-config.php file on the new Bitnami WordPress instance (typically located at /bitnami/wordpress)."
  type        = string
}

variable "use_external_db" {
  description = "Whether to use an external MySQL lightsail database instance or the built-in mariadb (-> standard) in the wordpress bitnami LAMP stack"
  type        = bool
}

variable "db_name_new" {
  description = "Name of new database"
  type        = string
}

variable "db_username_new" {
  description = "Username for the new database"
  type        = string
}

variable "bundle_id_mysql_db" {
  description = <<-EOT
  Bundle ID for the external Lightsail MySQL database.
  You can get the available database bundle IDs using the following AWS CLI command:
  aws lightsail get-relational-database-bundles --region <your-region> --output table
  EOT

  type = string
}

variable "tags" {
  description = "Tags to apply to AWS resources"
  type        = map(string)
}
