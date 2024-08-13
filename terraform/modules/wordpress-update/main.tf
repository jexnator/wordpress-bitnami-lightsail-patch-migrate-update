//***********************************************************
// main.tf
//
// This file contains the configuration for updating the 
// WordPress core, plugins and themes using WP-CLI.
//***********************************************************

resource "null_resource" "wordpress-update" {
  provisioner "file" {
    source      = "${path.module}/../../userdata/wp_update.sh.tftpl"
    destination = "/tmp/wp_update.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/wp_update.sh",
      "NEW_WP_PATH=${var.new_wp_path} UPDATE_WP_CORE=${var.update_wp_core} UPDATE_WP_PLUGINS=${var.update_wp_plugins} UPDATE_WP_THEMES=${var.update_wp_themes} bash /tmp/wp_update.sh && rm /tmp/wp_update.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = "bitnami"
    private_key = file("${var.ssh_key_path}")
    host        = var.new_wordpress_instance_ip
    agent       = true
  }

  provisioner "local-exec" {
    command = <<EOT
      scp -o StrictHostKeyChecking=no -i ${var.ssh_key_path} bitnami@${var.new_wordpress_instance_ip}:/home/bitnami/configure.log ../logs/configure.log
      scp -o StrictHostKeyChecking=no -i ${var.ssh_key_path} bitnami@${var.new_wordpress_instance_ip}:/home/bitnami/migrate.log ../logs/migrate.log
      scp -o StrictHostKeyChecking=no -i ${var.ssh_key_path} bitnami@${var.new_wordpress_instance_ip}:/home/bitnami/update.log ../logs/update.log
    EOT
  }
}
