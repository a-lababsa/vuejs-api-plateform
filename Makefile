PHP := php

.PHONY: install
install: build up /
	cp .env.example .env
	@docker-compose exec $(PHP) composer global require hirak/prestissimo
	$(MAKE) composer-install
	@docker-compose exec $(PHP) php artisan key:generate
	$(MAKE) node-install

help:
	@echo ""
	@echo "make install          ; install the project"
	@echo "make stop             ; stop project"
	@echo "make build            ; build project"
	@echo "make shell            ; build and start interactive shell in php containers"
	@echo "make composer-install ; run composer-install inside containers"
	@echo "make composer-update  ; run composer-update inside containers"
	@echo "make asset            ; build and install javascript modules"
	@echo "make node-sh          ; build and start interactive shell in node containers"
	@echo "make build            ; run docker-compose build"
	@echo "make down             ; run docker-compose down"
	@echo ""

up:
	@docker-compose up -d client

stop:
	@docker-compose stop

shell:
	@docker-compose exec php sh

composer-update:
	@docker-compose exec $(PHP) composer update --prefer-dist

composer-install:
	@docker-compose exec $(PHP) composer install --prefer-dist

yarn-install:
	@docker-compose run --rm yarn yarn install

yarn:
	@docker-compose run --rm yarn sh

asset:
	@docker-compose run --rm yarn yarn run assets

node-sh:
	@docker-compose run --rm node sh

build-app:
	$(info --> build base image)
	@( \
		docker build --force-rm -f app/docker/php/Dockerfile -t app_php  app/docker/php ; \
      	docker build --force-rm -f app/docker/nginx/Dockerfile -t app_nginx  app/docker/nginx; \
	)
	docker-compose build app


down:
	docker-compose down

build-client:
	$(info --> build base image)
	@( \
		docker build --force-rm -f client/docker/Dockerfile -t client_node .  ; \
		docker build --force-rm -f client/docker/nginx/Dockerfile -t client_nginx  client/docker/nginx; \
	)
	docker-compose build client

build:
	$(MAKE) build-app
	$(MAKE) build-client
