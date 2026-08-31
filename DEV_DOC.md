*This project has been created as part of the 42 curriculum by mtice*

# DEVELOPER Documentation

### Setting up the environment from scratch
#### Pre-requisites
* Access to `sudo` rights (otherwise consider launching inside a VM)
* Linux OS
* Access to a package manager, apt recommended
* It is recommended to update and upgrade your packages before
* The latest version of Docker and Docker Compose, to install, or update, you may launch the `docker_install.sh` script at the root of this repository

### Building and Launching the Project

#### Makefile

| Action                         | Command        |
| :------------------------------| :--------------|
| Build and start project        | make           |
| Stop project                   | make stop      |
| Restart project                | make restart   |
| Remove containers and volumes  | make clean     |
| Purge system of Docker files   | make fclean    |
| Purge system and re-build      | make re        |


#### Docker Compose
Note: If first build, do not forget the following pre-requisites:  
`mkdir -p ~/data/database/ ~/data/wordpress_files/`  
`sudo hostsed add 127.0.0.1 https://login.42.fr` or manually edit the file at /etc/hosts  
To remove after last purge:  
`sudo rm -rf ~/data/database/  ~/data/wordpress_files/`  
`sudo hostsed remove 127.0.0.1 https://login.42.fr` or manually edit file  

<sub>PATH: path to docker-compose.yml</sub>  

| Action                         | Command                                           |
| :------------------------------| :-------------------------------------------------|
| Build and start project        | docker compose -p inception -f PATH up --build -d |
| Stop project                   | docker compose -p inception stop                  |
| Restart project                | docker compose -p inception restart               |
| Remove containers and volumes  | docker compose -p inception down -v               |
| Purge system of Docker files   | docker system prune -a --volumes                  |


### Managing Containers and Volumes

#### Containers
To access a container, run:
```bash
docker exec -it <container> bash
```

#### Service Health: Service-Specific Troubleshooting

##### Nginx
Evidence that the nginx container setup is OK:  
```bash
docker exec nginx nginx -t
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
Evidence that WordPress is connected to MariaDB:
```bash
docker exec wordpress ping -c 1 mariadb
```
Expected output: `1 packets transmitted, 1 received, 0% packet loss, time 0ms`

Evidence that php-fpm is listening:
```bash
docker exec wordpress netstat -tuln | grep 9000
```
Expected output: `0.0.0.0:9000 LISTEN`

##### MariaDB
Evidence that mariadb is listening:
```bash
docker exec mariadb netstat -tuln | grep 3306
```
Expected output: `0.0.0.0:3306 LISTEN`

Evidence that mariadb is functioning:
```bash
docker exec -it mariadb mysql "SHOW DATABASES;"
```
Expected output: a table with existing databases

#### Volumes
Verify the version of a specific docker volume by testing:
```bash
docker volume inspect <volume name>
```

### Persistence of Project Data
To ensure that project data is not lost while containers are stopped, Docker volumes are remapped to a directory on the host computer. In this case, WordPress files are stored in ~/data/wordpress_files/ and the database information is stored in ~/data/database/. Therefore, when containers are restarted, the data persists and changes to the website and the database are stored.
