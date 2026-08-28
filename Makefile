NAME := inception
SRCS := ./srcs
COMPOSE := $(SRCS)/docker-compose.yml
HOST_URL := login.42.fr

all:
	mkdir -p ~/data/database
	mkdir -p ~/data/wordpress_files
	sudo hostsed add 127.0.0.1 $(HOST_URL)
	docker compose -p $(NAME) -f $(COMPOSE) up --build || (echo $ $(FAIL)$ && exit 1)

down:
	sudo hostset rm 127.0.0.1 $(HOST_URL)
	docker compose -p $(NAME) down

clean:
	docker rm -f $(docker ps -aq)
	docker rmi $(docker ps -aq)

fclean: clean
	docker system prune -a --volumes
	sudo rm -rf ~/data/database/
	sudo rm -rf ~/data/wordpress_files/

re: fclean all

.PHONY: all down clean fclean re
