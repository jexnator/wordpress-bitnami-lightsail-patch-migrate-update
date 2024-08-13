//***********************************************************
// variables.tf
//
// This file contains the variables required by the module
// bitnami-lightsail-instance.
//***********************************************************

variable "region" {
  description = "AWS Lightsail region"
  type        = string
}

variable "key_pair_name_new_instance" {
  description = "Name of the key pair for the new instance"
  type        = string
}

variable "bundle_id_bitnami_instance" {
  description = "Bundle ID for the Bitnami Lightsail instance"
  type        = string
}

variable "use_external_db" {
  description = "Whether to use an external MySQL lightsail database instance or the built-in mariadb (-> standard) in the wordpress bitnami LAMP stack"
  type        = bool
}

variable "db_name_new" {
  description = "Name of the new database"
  type        = string
}

variable "db_username_new" {
  description = "Username for the new database"
  type        = string
}

variable "db_password" {
  description = "Password for the new database"
  type        = string
}

variable "db_host" {
  description = "Host address of the new database"
  type        = string
}

variable "db_wp_table_prefix" {
  description = "The table prefix for WordPress"
  type        = string
}

variable "new_wp_path" {
  description = "Path to the wordpress installation (e.g. wp-content folder) on the new bitnami wordpress instance"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
