FROM debian:bookworm

# Indicates that the conatiner will be listening on port 3306
EXPOSE 3306

# --no-install-recommends and --no-install-suggests avoid installing unnecessary packages
# && avoids creating unnecessary layers
# rm -rf /var/lib/apt/lists/* is used to clean apt cache and avoid unnecessary files
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
    mariadb-server \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# TODO:
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# Copy the config file to the container
# COPY <file path in the host> <file path to receive file>
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Setup script
COPY tools/setup.sh /bin/
RUN chmod +x /bin/setup.sh

# Execute the setup script and then start the database server
CMD ["setup.sh", "mysqld_safe"]
# ENTRYPOINT ["/bin/setup.sh"]
