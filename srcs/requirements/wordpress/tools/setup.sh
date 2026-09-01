#!/bin/bash

set -euo pipefail

WP_DIR=/var/www/inception/
DB_PASSWORD="$(cat /run/secrets/db_password)"
WP_ADMIN_PASSWORD="$(cat /run/secrets/wp_admin_password)"
WP_PASSWORD="$(cat /run/secrets/wp_password)"

chown -R www-data:www-data "$WP_DIR"

# # Check if wp-config.php already exists ---------------------------------------
if [ ! -f "$WP_DIR""wp-config.php" ]; then
   mv /tmp/wp-config.php "$WP_DIR"
fi
# # -----------------------------------------------------------------------------

# Wait until MariaDB is ready -------------------------------------------------
until mysqladmin ping \
	-h"$DB_HOST" \
	-u"$DB_USER" \
	-p"$DB_PASSWORD" \
	--silent
do
	echo "Waiting for MariaDB..."
	sleep 2
done
echo "MariaDB is ready."
#------------------------------------------------------------------------------

# Check if WordPress files already exist --------------------------------------
if [ ! -f "$WP_DIR""wp-includes/version.php" ];
then
	echo "Downloading WordPress..."
	wp --allow-root --path="$WP_DIR" core download
else
	echo "WordPress files already exist, skipping download."
fi
#------------------------------------------------------------------------------

# Check if WordPress core is installed ----------------------------------------
if wp --allow-root --path="$WP_DIR" core is-installed;
then
	echo "WordPress is already installed."
else
	echo "Installing WordPress..."
	wp --allow-root --path="$WP_DIR" core install \
	--url="$WP_URL" \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN_USER" \
	--admin_password="$WP_ADMIN_PASSWORD" \
	--admin_email="$WP_ADMIN_EMAIL"
	echo "Admin user created"
fi
#------------------------------------------------------------------------------

# Create the non-admin user and set its role ----------------------------------
if ! wp --allow-root --path="$WP_DIR" user get "$WP_USER";
then
	wp --allow-root --path="$WP_DIR" user create \
	   "$WP_USER" \
	   "$WP_EMAIL" \
	   --user_pass="$WP_PASSWORD" \
	   --role="$WP_ROLE"
	echo "$WP_USER created"
fi;
#------------------------------------------------------------------------------

# start the php server in the foreground
exec php-fpm8.2 --nodaemonize
