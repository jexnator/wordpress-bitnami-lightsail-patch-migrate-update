//***********************************************************
// main.tf
//
// This file contains the configuration for deploying a MySQL
// database in AWS Lightsail. The database is used by the 
// WordPress Bitnami instance for storage.
//***********************************************************

resource "random_password" "random_db_password" {
  length           = 32
  special          = true
  override_special = "!#%()*+-_={}[]<>?"
}

locals {
  custom_timestamp = formatdate("YYYY-MM-DD-HH-mm-ss", timestamp())
}

resource "aws_lightsail_database" "wordpress_my_sql_db" {
  relational_database_name = "wordpress-mysql-${var.env}-${local.custom_timestamp}"
  availability_zone        = "${var.region}a"
  blueprint_id             = "mysql_8_0"
  bundle_id                = var.bundle_id_mysql_db
  master_database_name     = var.db_name
  master_username          = var.db_username
  master_password          = random_password.random_db_password.result
  final_snapshot_name      = "wordpress-mysql-final-snapshot-${var.env}-${local.custom_timestamp}"
  skip_final_snapshot      = false

  tags = var.tags
}

output "db_host" {
  value = "${aws_lightsail_database.wordpress_my_sql_db.master_endpoint_address}:${aws_lightsail_database.wordpress_my_sql_db.master_endpoint_port}"
}

output "db_password" {
  value     = random_password.random_db_password.result
  sensitive = true
}
