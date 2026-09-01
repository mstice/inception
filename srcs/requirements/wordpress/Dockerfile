FROM debian:bookworm

EXPOSE 9000

# Set a variable for clarity
ARG PHPPATH=/etc/php/8.2/fpm

# Update the system and install required dependencies
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
    ca-certificates \
    php8.2-fpm \
    php8.2-mysql \
    mariadb-client \
    wget \
    tar \
    netcat-openbsd \
    curl \
    net-tools \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# After php installation it runs aturomatically
# Stop to change configuration file
RUN service php8.2-fpm stop

COPY conf/www.conf ${PHPPATH}/pool.d/

# Fix the info in the configuration file
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${PHPPATH}/php.ini && \
	sed -i "s/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g" ${PHPPATH}/pool.d/www.conf && \
	sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' ${PHPPATH}/pool.d/www.conf && \
	sed -i 's/;daemonize = yes/daemonize = no/g' ${PHPPATH}/pool.d/www.conf

# Download the wordpress CLI
RUN wget --no-check-certificate https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Create some folders needed by the wordpress files
RUN mkdir -p /run/php/ && \
    mkdir -p /var/run/php/ && \
	mkdir -p /var/www/inception/

# Change owner to www-data user
RUN chown -R www-data:www-data /var/www/inception

# Copy the config file needed for wp-cli
COPY conf/wp-config.php /tmp/

# Copy the setup script used to install wordpress
COPY tools/setup.sh /bin/
RUN chmod +x /bin/setup.sh

# Launch setup script which installs wordpress
# --nodaemonize avoids the php server running in the background
ENTRYPOINT ["/bin/setup.sh"]
