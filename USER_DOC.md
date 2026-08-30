*This project has been created as part of the 42 curriculum by mtice*

# USER Documentation

### Services Provided
The stack provides the following services: Nginx as the server, WordPress as the Website, and MariaDB as the database. With Docker, the back-end becomes a conjunction of independently contained microservices, which are connected through a Docker network, made possible by internal ports and their Docker-specific DNS resolution.  

Nginx is the only service which is outward-facing, connecting to the Host computer through an internal port 443, and exposing the website through the server name login.42.fr remapped from 127.0.0.1 (*login* here refers to the login of the author of the project). Nginx then internally communicates with WordPress through an internal port 9000. WordPress works with php-fpm v8.2, and wp-cli which is installed via an entrypoint script and is used to set up the basic WordPress site. MariaDB communicates with WordPress through an internal port 3306, and stores relevant data from the website.

Two volumes located at ~/data/database/ and ~/data/wordpress_files/ ensure that the database data and wordpress_files persist when the docker build is stopped.

### Usage: Starting and Stopping the Docker Service
To start the docker services for the first time, run `make` in your terminal.  
To stop the docker services, run `make stop`.  
To restart an existing build, run `make restart`.  
More detailed make commands are listed in the README.md file at the root of this repository.

Usage without a Makefile:
In the same location as the `docker-compose.yml` file, you can perform the following actions:  

To start the services for the first time:  
```bash
docker compose up --build -d -p inception
```
To stop the services:  
```bash
docker compose -p inception stop
```
To restart the services:  
```bash
docker compose -p inception restart
```
To remove previous builds:
```bash
docker compose -p inception down -v
```
To fully purge all previous images, builds, volumes:  
```bash
docker system prune -a --volumes
sudo rm -rf ~/data/database/
sudo rm -rf ~/data/wordpress_files/
```
To inspect the project:  
```bash
docker ps
docker images
```
### Website: Accessing and Administration
To configure the website in a user-friendly way, simply go to https://login.42.fr/wp-admin.

### Managing Credentials

### Verifying Service Health

#### Service Health: Initial Troubleshooting
The `docker-compose.yml` file already includes basic health checks for all three services.
The health status of each container can be verified by running `docker ps` in the terminal.
Services can be `healthy` or `unhealthy`. MariaDB is dependent on WordPress having started and being healthy, and Nginx is similarly dependent on WordPress.
If a service does not start at all, this can also be an indication that a dependent service is unhealthy.  

Before assuming an issue with project itself check the following:
* Your internet connection
* That you are using a compatible browser (Chromium recommended)
* That you have the most up to date version of Docker installed (!!!!!version)
* That you have docker compose installed (!!!!!TODO: docker compose version command)
* That your browser settings are set to the default recommended settings
* That you have run `make fclean` before attempting to build again

General project troubleshooting:

To identify the problematic service, run:
<sub>*Note that it might take 1-2 minutes for the healthy checks to run through*</sub>
```bash
make fclean
make
docker ps -a
```
Expected output:
| NAMES     | STATUS     | PORTS                                   |
|:----------|:-----------|:----------------------------------------|
| nginx     | (healthy)  | 0.0.0.0:443->443/tcp, [::]:443->443/tcp |
| wordpress | (healthy)  | 9000/tcp                                |
| mariadb   | (healthy)  | 3306/tcp                                |

#### Service Health: Service-Specific Troubleshooting

##### Nginx
Evidence that the nginx container setup is OK:  
```bash
docker exec -it nginx bash
nginx -t
exit
```
Expected output:  
`nginx: the configuration file *location* syntax is ok`  
`nginx: configuration file *location* test is successful`  

Evidence the website is up and running:  
```bash
ping -c 1 login.42.fr
```
Expected output: `1 packets transmitted, 1 received, 0% packet loss, time 0ms`  

Evidence of successful connection to website:  
```bash
curl -k -I https://login.42.fr
```
Expected output: `HTTP/1.1 200 OK` `Server: nginx/1.22.1`  

##### WordPress
Evidence that WordPress exists:  
```bash
docker exec -it wordpress bash

exit
```

##### MariaDB
Check which databases exist:
```bash
docker exec -it mariadb bash

```



