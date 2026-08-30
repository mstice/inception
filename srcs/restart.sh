#!/bin/bash

docker compose down

docker system prune -a --volumes

sudo rm -rf ~/data/database/* ~/data/wordpress_files/*

docker compose up --build
