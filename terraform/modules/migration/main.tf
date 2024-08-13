//***********************************************************
// main.tf
//
// This file contains the configuration for migrating a 
// WordPress Bitnami instance from an old server to a new
// server using WP-CLI.
//***********************************************************

resource "null_resource" "migrate_wordpress" {
  provisioner "file" {
    source      = "${path.module}/../../userdata/migrate_wordpress.sh.tftpl"
    destination = "/tmp/migrate_wordpress.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/migrate_wordpress.sh",
      "OLD_SERVER_IP=${var.old_wordpress_instance_ip} NEW_SERVER_IP=${var.new_wordpress_instance_ip} OLD_WP_PATH=${var.old_wp_path} NEW_WP_PATH=${var.new_wp_path} bash /tmp/migrate_wordpress.sh && rm /tmp/migrate_wordpress.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = "bitnami"
    private_key = file("${var.ssh_key_path_new_instance}")
    host        = var.new_wordpress_instance_ip
    agent       = true
  }
}
