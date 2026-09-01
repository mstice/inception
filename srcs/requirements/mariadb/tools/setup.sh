#!/bin/bash

set -e

DATA_DIR="/var/lib/mysql"
SOCKET="/run/mysqld/mysqld.sock"
DB_PASS_ROOT="$(cat /run/secrets/db_root_password)"
DB_PASSWORD="$(cat /run/secrets/db_password)"

echo "Starting MariaDB setup..."

# Initialize MySQL data directory if it doesn't exist--------------------------
if [ ! -d "$DATA_DIR"/mysql ]; then
    echo "Initializing data directory..."
    mariadb-install-db --user=mysql --datadir="$DATA_DIR" > /dev/null
fi
#------------------------------------------------------------------------------

# Start the server (no networking for setup)-----------------------------------
echo "Starting temporary MariaDB server"
mariadbd --user=mysql \
        --datadir="$DATA_DIR" \
        --socket="$SOCKET" \
        --skip-networking \
        --console &
pid="$!"
#------------------------------------------------------------------------------

# Wait for MariaDB to be ready ------------------------------------------------
echo "Waiting for MariaDB..."
until mariadb-admin --socket="$SOCKET" ping --silent; do
    sleep 1
done
echo "MariaDB is ready!"
#------------------------------------------------------------------------------

# Create database and users ---------------------------------------------------
echo "Creating the database..."
mysql --socket="$SOCKET" -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASS_ROOT}';
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF
#------------------------------------------------------------------------------

# Shut down temporary server---------------------------------------------------
echo "Shutting down temporary MariaDB..."
mariadb-admin --socket="$SOCKET" -u root -p"${DB_PASS_ROOT}" shutdown

# Wait for shutdown
wait "$pid" || true
#------------------------------------------------------------------------------

# Start MariaDB normally-------------------------------------------------------
echo "Starting final MariaDB server..."

echo "Starting MariaDB..."
exec mariadbd --user=mysql \
              --datadir="$DATA_DIR" \
              --socket="$SOCKET" \
              --console
#------------------------------------------------------------------------------
