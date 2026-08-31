*This project has been created as part of the 42 curriculum by mtice*

# Inception

### Description
Inception is an introductory project to Docker and containerisation.
The goal of this project is to set up a small infrastructure that launches various contained services which together form the application.
This final resulting application is a basic website served by Nginx, hosted by WordPress and maintained by MariaDB.  

**Nginx** → receives HTTP/HTTPS requests  
**WordPress + PHP-FPM** → execute the WordPress application  
**MariaDB** → stores data from WordPress  
**Docker network** → allows containers to communicate  
**Docker volumes** → ensure data survives container destruction  

### Instructions

#### Prerequisites:
* Sudo permissions
* Docker and docker compose
	* Install it yourself or
	* Install via provided script: `sh docker_install.sh`
* Hostsed
	* Install with your favourite package manager
	* e.g. `sudo apt install hostsed`

#### Usage:
1. Build the project by running `make`
2. Open a browser (Chromium recommended) and go to https://mtice.42.fr
3. You should be greeted by a functional WordPress Website!

#### Usage Commands:

| Action                         | Command        |
| :------------------------------| :--------------|
| Build and start service        | make           |
| Stop service                   | make stop      |
| Restart service                | make restart   |
| Remove containers and volumes  | make clean     |
| Purge system of Docker files   | make fclean    |
| Purge system and re-build      | make re        |


### Resources
**Docker, Dockerfiles, docker-compose.yml files:**  
[Intro to Docker by Jake Wright](https://www.youtube.com/watch?v=YFl2mCHdv24)  
[Intro to Dockerfiles: Learn X in Y Minutes](https://learnxinyminutes.com/docker/)  
[Intro to Docker Compose by Jake Wright](https://www.youtube.com/watch?v=Qw9zlE3t8Ko)  
[Official WordPress Dockerfile](https://github.com/docker-library/wordpress/blob/master/wp-config-docker.php)  

**Configuration Files:**  
[Beginner's Guide to NGINX](https://nginx.org/en/docs/beginners_guide.html)  
[PHP Configuration Files by PHP](https://www.php.net/manual/en/install.fpm.configuration.php)  
[Official wp-config.php file](https://github.com/docker-library/wordpress/blob/master/latest/php8.2/fpm/wp-config-docker.php)  
[Linux From Scratch: Mariadb Configuration](https://www.linuxfromscratch.org/blfs/view/git/server/mariadb.html)  

**Entrypoint Scripts:**  
[WP-CLI v2 Managing WordPress from the Terminal](https://kinsta.com/blog/wp-cli/)  
[MySql Official Docker Entrypoint Script](https://github.com/docker-library/mysql/blob/master/9.7/docker-entrypoint.sh)  

### Project Description: Theory

**Virtual Machines vs Docker**  
A virtual machine (VM) virtualises an entire computer, whereas Docker virtualises an application.

Docker deploys various services in containers which work together to form an application.
Docker works independently of the system OS, and is ideal for efficient deployment of lightweight applications, requiring minimal resource usage.

Virtual Machines emulate an entire physical machine, with a specific OS.
They are more resource-intensive, but more secure as they are completely isolated from the host computer.
They are better for full-scale workloads that rely on a specific OS, so are less portable.

**Secrets vs Environment Variables**  
Secrets and environment variables are both used to store sensitive information such as credentials, user names and passwords.
Secrets are typically used to store passwords, as they are more secure than storing the data in environment variables.
Docker secrets are encrypted at rest and transit.
They only accessible to services explicitly granted permission and only while that service is running.
They are mounted as temporary files in /run/secrets within the container, making them less prone to exposure in logs, for example.
Lastly, with Docker secrets, each password is stored in an independent file.
Docker secrets are limited to Docker Swarm and cannot be used with standalone containers.  

Environment variables are less secure, as they are stored in plain text and accessible to any process with sufficient privilege.
They persist in the container's runtime environment, and even if removed, they may still be retrievable from the Docker engine's metadata.
Environment variables can be easily accessed by running a command such as `docker exec <container> env`.  

**Docker Network vs Host Network**  
A Docker network is a network inside the Docker engine.
The most common Docker network type is a bridge network.
Here, each container get its on network namespace and a virtual Ethernet interface connected to a software bridge.
The Docker network is internal to the Docker engine, and allows containers to communicate amongst themselves with automatic DNS resolution by container name.
This type of networking is suited for applications requiring few ports for external access, keeping most of the communication between services internal, and therefore is therefore safer.

Instead of the Docker network, host networking can be configured, where the container shares the host's network stack. The container's ports are the host's ports and there is no NAT layer.
This is a less safe option, as more services are exposed. Yet it may be desirable during production, where many containers must be monitored, or necessary due to application design. Host networking is desirable for high-performance networking apps, as it is faster than utilising a Docker network.  

**Docker Volumes vs Bind Mounts**  
Volumes and bind mounts are both used to ensure container data persistence.

Volumes are stored in the local host, and are independent of the host's directory structure and OS.
They are managed by Docker and are easier to migrate.
Commonly used to store databases, production data, backups and for multi-container sharing.

Bind mounts link a docker host path to a container.
They provide instant access to host files, useful for live updates during development.
Bind mounts allow host file access.
They depend on host's file system, making them less portable than volumes.
