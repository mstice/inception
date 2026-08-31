GREEN := \033[0;92m
CYAN := \033[0;96m
MAGENTA := \033[0;95m
RED := \033[0;91m
RESET := \033[0m

NAME := inception

BANNER := \
\n \
                                                   \n \
                                                   \n \
██ ▄▄  ▄▄  ▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄ ▄▄▄▄▄▄ ▄▄  ▄▄▄  ▄▄  ▄▄  \n \
██ ███▄██ ██▀▀▀ ██▄▄  ██▄█▀  ██   ██ ██▀██ ███▄██  \n \
██ ██ ▀██ ▀████ ██▄▄▄ ██     ██   ██ ▀███▀ ██ ▀██  \n \
                                                   \n \
\n \

SRCS := ./srcs

COMPOSE := $(SRCS)/docker-compose.yml

HOST_URL := mtice.42.fr

all:
	@printf "${GREEN} $(BANNER) ${RESET}\n"
	mkdir -p ~/data/database
	mkdir -p ~/data/wordpress_files
	sudo hostsed add 127.0.0.1 $(HOST_URL)
	@docker compose -p $(NAME) -f $(COMPOSE) up --build -d || (echo $ $(FAIL)$ && exit 1)

stop:
	@printf "${RED}[Makefile]: STOPPING SERVICE...\n${RESET}"
	@docker compose -p $(NAME) stop

restart:
	@if [ $(docker ps -a | wc -l) > 1 ]; then \
		printf "${GREEN}[Makefile]: RESTARTING SERVICE...\n${RESET}"; \
		docker compose -p $(NAME) restart; \
	else \
		printf "${GREEN}[Makefile]: NO CONTAINERS TO RESTART\n${RESET}"; \
	fi

clean:
	@printf "${CYAN}[Makefile]: STOPPING, REMOVING CONTAINERS AND VOLUMES...\n${RESET}"
	@docker compose -p $(NAME) down -v

fclean: clean
	@printf "${CYAN}[Makefile]: CLEANING ALL DOCKER FILES IN SYSTEM\n${RESET}"
	@sudo hostsed rm 127.0.0.1 $(HOST_URL)
	@docker system prune -a --volumes
	@sudo rm -rf ~/data/database/
	@sudo rm -rf ~/data/wordpress_files/

re: fclean all

.PHONY: all down clean fclean re
