## Module: bitnami-lightsail-instance

This module provisions a new AWS Lightsail instance using the latest WordPress (from Bitnami) image. It handles the following:

**Instance Creation**: Launches a new WordPress Lightsail instance (pre-packaged by Bitnami):

- Configs: Associates the specified SSH key pair with the new instance and sets up your instance according the specified bundle_id.
- Snapshots: Enables auto snapshots on a daily basis (00:00 UTC) for your new WordPress Lightsail instance
- wp-config.php: Configures the new WordPress instance with the necessary settings, including database credentials (optional) and table prefixes (optional).

## Module: external-lightsail-mysql-db

This module is optional and used only if you choose to configure an external MySQL database instead of using the internal MariaDB on the Wordpress Bitnami Lightsail instance. It handles:

- **Database Provisioning**: Creates a new Lightsail MySQL database instance with the specified resource bundle.
- **Database Configuration**: Sets up the new database with the provided name and username.
- **Password Management**: Generates a secure password for the database and outputs it for use in the WordPress configuration.

## Module: migration

This module manages the migration of WordPress content and database from the old Wordpress Bitnami Lightsail instance to the new one. It handles:

- **Content Migration**: Uses `rsync` over SSH to securely transfer the `wp-content`, `wp-admin`, and `wp-includes` directories from the old instance to the new one.
- **Database Migration**: Exports the WordPress database from the old instance and imports it into the new instance using `wp-cli`.
- **SSH Connection Management**: Establishes secure SSH connections to both the old and new instances for the migration process.

## Module: wordpress-update

This module is responsible for updating WordPress components via `wp-cli` on the new instance after the migration is complete. It handles:

- **Core Update**: Optionally updates the WordPress core to the latest version.
- **Plugin Update**: Optionally updates all installed WordPress plugins to their latest versions.
- **Theme Update**: Optionally updates all installed WordPress themes to their latest versions.
- **Logging**: Captures detailed logs of the update process and retrieves them to your local machine for review.
