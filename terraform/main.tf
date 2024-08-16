//***********************************************************
// main.tf
//
// This file defines the primary configuration for deploying
// a new WordPress Bitnami instance (and an optional MySQL 
// database) in AWS Lightsail. Due to the constraints of 
// the Bitnami Core-Stack, where LAMP components cannot be 
// updated individually, this setup involves deploying a new 
// instance with the latest Bitnami image. Subsequently, the 
// content is migrated from the old instance to the new one 
// to ensure all components are up-to-date.
//
// After the migration, the WordPress core version, plugins, 
// and themes are updated to the latest versions.

// The configuration utilizes the latest AWS Lightsail
// Bitnami (and MySQL) image.
//***********************************************************

terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.63"
    }
  }
}

provider "aws" {
  region = var.region
}

module "external-lightsail-mysql-db" {
  source             = "./modules/external-lightsail-mysql-db"
  region             = var.region
  bundle_id_mysql_db = var.bundle_id_mysql_db
  db_name            = var.db_name_new
  db_username        = var.db_username_new
  env                = var.env
  tags               = var.tags
  count              = var.use_external_db ? 1 : 0
}

module "bitnami-lightsail-instance" {
  source                     = "./modules/bitnami-lightsail-instance"
  region                     = var.region
  key_pair_name_new_instance = var.key_pair_name_new_instance
  bundle_id_bitnami_instance = var.bundle_id_bitnami_instance
  db_name_new                = var.db_name_new
  db_username_new            = var.db_username_new
  db_password                = var.use_external_db ? module.external-lightsail-mysql-db[0].db_password : "password"
  db_host                    = var.use_external_db ? module.external-lightsail-mysql-db[0].db_host : "host"
  db_wp_table_prefix         = var.db_wp_table_prefix
  new_wp_path                = var.new_wp_path
  env                        = var.env
  tags                       = var.tags
  use_external_db            = var.use_external_db
  depends_on                 = [module.external-lightsail-mysql-db]
}

module "migration" {
  source                    = "./modules/migration"
  ssh_key_path_old_instance = var.ssh_key_path_old_instance
  ssh_key_path_new_instance = var.ssh_key_path_new_instance
  old_wordpress_instance_ip = var.old_wordpress_instance_ip
  new_wordpress_instance_ip = module.bitnami-lightsail-instance.wordpress_instance_ip
  old_wp_path               = var.old_wp_path
  new_wp_path               = var.new_wp_path
  depends_on                = [module.bitnami-lightsail-instance]
}

module "wordpress-update" {
  source                    = "./modules/wordpress-update"
  ssh_key_path              = var.ssh_key_path_new_instance
  new_wordpress_instance_ip = module.bitnami-lightsail-instance.wordpress_instance_ip
  new_wp_path               = var.new_wp_path
  update_wp_core            = var.update_wp_core
  update_wp_plugins         = var.update_wp_plugins
  update_wp_themes          = var.update_wp_themes
  depends_on                = [module.migration]
}

output "wordpress_instance_ip" {
  value = module.bitnami-lightsail-instance.wordpress_instance_ip
}
