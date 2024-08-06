include .env

SHELL := /bin/bash
.DEFAULT_GOAL := help
DOCKER_COMPOSE := docker-compose
COMPOSER := composer

.PHONY: help start build stop scaffold container migrate seed composer key

help:
	@echo "Laravel Eleven Makefile"
	@echo "---------------------"
	@echo "Usage: make <command>"
	@echo ""
	@echo "Commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-26s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

start: ## Start all containers
	$(DOCKER_COMPOSE) up -d

build: ## Build all containers without detach
	$(DOCKER_COMPOSE) up --build

stop: ## Stop all containers
	$(DOCKER_COMPOSE) down -v

scaffold: ## Start config to project
	mkdir -p .database/postgresql

container: ## Enter the container
	docker exec -it php-laravel-eleven bash

migrate: ## Enter the container and run migrate
	docker exec php-laravel-eleven php artisan migrate

seed: ## Enter the container and run db:seed
	docker exec -it php-laravel-eleven php artisan db:seed

composer: ## Enter the container and composer install
	docker exec -it php-laravel-eleven composer install

key: ## Enter the container and run key generate
	docker exec -it php-laravel-eleven php artisan key:generate
