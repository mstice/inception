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
`sudo hostset remove 127.0.0.1 https://login.42.fr` or manually edit file  

PATH: path to docker-compose.yml  
NAME: name of dev project  

| Action                         | Command                                      |
| :------------------------------| :--------------------------------------------|
| Build and start project        | docker compose -p NAME -f PATH up --build -d |
| Stop project                   | docker compose -p NAME stop                  |
| Restart project                | docker compose -p NAME restart               |
| Remove containers and volumes  | docker compose -p (NAME) down -v             |
| Purge system of Docker files   | docker system prune -a --volumes             |



### Managing and Containers and Volumes

#### Containers
To access a container, run:
```bash
docker exec -it <container> bash
```

#### Volumes

### Persistence of Project Data
To ensure that project data is not lost while containers are stopped, Docker volumes are remapped to a directory on the host computer. In this case, WordPress files are stored in ~/data/wordpress_files/ and the database information is stored in ~/data/database/. Therefore, when containers are restarted, the data persists and changes to the website and the database are stored.
