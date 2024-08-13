//***********************************************************
// variables.tf
//
// This file contains the variables required by the module
// external-lightsail-mysql-db.
//***********************************************************

variable "region" {
  description = "AWS Lightsail region"
  type        = string
}

variable "bundle_id_mysql_db" {
  description = "Bundle ID for the external Lightsail MySQL database"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Username for the database"
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
