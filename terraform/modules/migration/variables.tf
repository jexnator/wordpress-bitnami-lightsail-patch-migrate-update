//***********************************************************
// variables.tf
//
// This file contains the variables required by the module
// migration.
//***********************************************************

variable "ssh_key_path_old_instance" {
  description = "Path to the SSH private key for the old instance"
  type        = string
}

variable "ssh_key_path_new_instance" {
  description = "Path to the SSH private key for the new instance"
  type        = string
}

variable "old_wordpress_instance_ip" {
  description = "IP of the old wordpress instance which needs to be replaced"
  type        = string
}

variable "new_wordpress_instance_ip" {
  description = "IP address of the new WordPress server"
  type        = string
}

variable "old_wp_path" {
  description = "Path to the wordpress installation (e.g. wp-content folder) on the old bitnami wordpress instance"
  type        = string
  default     = "/bitnami/wordpress"
}

variable "new_wp_path" {
  description = "Path to the wordpress installation (e.g. wp-content folder) on the new bitnami wordpress instance"
  type        = string
  default     = "/bitnami/wordpress"
}
