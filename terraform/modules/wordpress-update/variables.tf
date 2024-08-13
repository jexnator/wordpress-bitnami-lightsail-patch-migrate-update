//***********************************************************
// variables.tf
//
// This file contains the variables required by the module
// wordpress-update.
//***********************************************************

variable "ssh_key_path" {
  description = "Path to the SSH private key"
  type        = string
}

variable "new_wordpress_instance_ip" {
  description = "IP address of the new WordPress server"
  type        = string
}

variable "new_wp_path" {
  description = "Path to the wordpress installation (e.g. wp-content folder) on the new bitnami wordpress instance"
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
