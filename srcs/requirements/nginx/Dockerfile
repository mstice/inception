FROM debian:bookworm

EXPOSE 443

# Install the required dependencies
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
    nginx \
    openssl \
    netcat-openbsd \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ARG CERT_FOLDER \
    CERTIFICATE \
    KEY \
    COUNTRY \
    STATE \
    LOCALITY \
    ORGANIZATION \
    UNIT \
    COMMON_NAME

# Generate the SSL certificate
RUN mkdir -p ${CERT_FOLDER} && \
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out ${CERTIFICATE} \
    -keyout ${KEY} \
    -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${UNIT}/CN=${COMMON_NAME}"


COPY conf/default /etc/nginx/sites-available/

# Create the directory for WordPress files
RUN mkdir -p /var/www/
RUN chown -R www-data:www-data /var/www/

CMD ["nginx", "-g", "daemon off;"]
