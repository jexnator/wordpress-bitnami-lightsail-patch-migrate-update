//***********************************************************
// main.tf
//
// This file contains the configuration for deploying a 
// WordPress Bitnami instance in AWS Lightsail. The instance
// is configured to connect to an external MySQL database if
// specified, otherwise it uses the built-in Bitnami database.
//***********************************************************

locals {
  custom_timestamp = formatdate("YYYY-MM-DD-HH-mm-ss", timestamp())
}

resource "aws_lightsail_instance" "wordpress_instance" {
  name              = "wordpress-${var.env}-${local.custom_timestamp}"
  availability_zone = "${var.region}a"
  blueprint_id      = "wordpress"
  bundle_id         = var.bundle_id_bitnami_instance
  key_pair_name     = var.key_pair_name_new_instance

  user_data = templatefile("${path.module}/../../userdata/wp_config.sh.tftpl", {
    DB_NAME         = var.db_name_new,
    DB_USER         = var.db_username_new,
    DB_PASSWORD     = var.db_password,
    DB_HOST         = var.db_host,
    WP_TABLE_PREFIX = var.db_wp_table_prefix,
    NEW_WP_PATH     = var.new_wp_path,
    USE_EXTERNAL_DB = var.use_external_db
  })

  tags = var.tags

  add_on {
    type          = "AutoSnapshot"
    snapshot_time = "00:00"
    status        = "Enabled"
  }
}

output "wordpress_instance_ip" {
  value = aws_lightsail_instance.wordpress_instance.public_ip_address
}
