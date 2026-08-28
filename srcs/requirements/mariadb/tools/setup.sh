#!/bin/bash

# set -euo pipefail
#
# if [ ! -d /var/lib/mysql/mysql ]; then
# 	mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null
#
# mysqld --user=mysqld \
#        --datadir=/var/lib/mysql \
#        --socket=/run/mysqld/mysqld.sock \
#        --skip-networking \
#        --skip-grant-tables &
# temp_pid=$!
#
# until mysqladmin -ping --socket=/run/mysqld/mysqld.sock --silent;
# do
# 		sleep 1
# done
#
# echo $DB_NAME
# echo $DB_USER
# echo $DB_PASSWORD

service mariadb start

mariadb -v -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_PASS_ROOT';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PASS_ROOT');
EOF

sleep 5
service mariadb stop
exec "$@"

# # stop mariadb server
# mysqladmin --socket=/run/mysqld/mysqld.sock shutdown
# wait "$temp_pid"
# fi
#
# # start mariadb server
# exec mysqld --user=mysql \
#             --datadir=/var/lib/mysql \
#             --socket=/run/mysqld/mysqld.sock \
#             --bind-address=0.0.0.0 \
#             --console
