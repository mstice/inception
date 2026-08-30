*This project has been created as part of the 42 curriculum by mtice*

# Inception

### Description
Inception is an introductory project to Docker and containerisation. The goal of this project is to set up a small infrastructure that
Nginx -> receives HTTP/HTTPS requests
WordPress + PHP-FPM -> execute the WordPress application
MariaDB -> stores data from WordPress
Docker network -> allows containers to communicate
Docker volumes -> ensure data survives container destruction

### Instructions

#### Prerequisites:
* Sudo permissions
* Docker and docker compose
	* Install it yourself or
	* Install via provided script: `sh docker_install.sh`
* Hostsed
	* Install with your favourite package manager
	* e.g. `sudo apt install hostsed`

#### Usage Instructions:

| Action                         | Command        |
| :------------------------------| :--------------|
| Build and start service        | make           |
| Stop service                   | make stop      |
| Restart service                | make restart   |
| Remove containers and volumes  | make clean     |
| Purge system of Docker files   | make fclean    |
| Purge system and re-build      | make re        |

#### Usage:
1. Build the project by running `make`
2. Open a browser (Chromium recommended) and go to https://\<login\>.42.fr
3. You should be greeted by a functional WordPress Website!


### Resources
**Docker, Dockerfiles, docker-compose.yml files**  
[Intro to Docker by Jake Wright](https://www.youtube.com/watch?v=YFl2mCHdv24)  
[Intro to Dockerfiles: Learn X in Y Minutes](https://learnxinyminutes.com/docker/)  
[Intro to Docker Compose by Jake Wright](https://www.youtube.com/watch?v=Qw9zlE3t8Ko)  
[Official WordPress Dockerfile](https://github.com/docker-library/wordpress/blob/master/wp-config-docker.php)  

**Configuration Files**  
[Beginner's Guide to NGINX](https://nginx.org/en/docs/beginners_guide.html)  
[PHP Configuration Files by PHP](https://www.php.net/manual/en/install.fpm.configuration.php)  
[Official wp-config.php file](https://github.com/docker-library/wordpress/blob/master/latest/php8.2/fpm/wp-config-docker.php)  
[Linux From Scratch: Mariadb Configuration](https://www.linuxfromscratch.org/blfs/view/git/server/mariadb.html)  

**Entrypoint Scripts**  
[WP-CLI v2 Managing WordPress from the Terminal](https://kinsta.com/blog/wp-cli/)  
[MySql Official Docker Entrypoint Script](https://github.com/docker-library/mysql/blob/master/9.7/docker-entrypoint.sh)  

### Project Description

#### Theory:  
**Virtual Machines vs Docker**  
**Secrets vs Environment Variables**  
**Docker Network vs Host Network**  
**Docker Volumes vs Bind Mounts**  

