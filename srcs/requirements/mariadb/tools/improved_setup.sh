#!/bin/bash

set -e

echo "Mariadb: Setup script"

if [ ! -d "/var/lib/mysql" ]; then
	echo "Initialising data directory..."
	mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

echo "Starting temporary MariaDB server for setup..."
mysqld --skip-networking --socket=/run/mysqld/mysqld.sock --user=mysql & pid="$!"

echo "Waiting for MariaDB to be ready..."
until mysqladmin --socket=/run/mysql/mysqld.sock ping >/dev/null 2>&1; do
	sleep 1
done
echo "MariaDB is ready!"

echo "Running setup SQL..."
mysql --socket=/run/mysqld/mysqld.sock -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASS_ROOT}';
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "Shutting down temporary MariaDB..."
mysqladmin --socket=/run/mysqld/mysqld.sock -u root -p"${DB_PASS_ROOT}" shutdown

wait "$pid" || true


echo "Initialisation complete. Starting MariaDB..."
exec mysqld --user=mysql --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock
