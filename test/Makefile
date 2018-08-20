# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
.ONESHELL:
.SHELL := /bin/bash
.PHONY: help
.DEFAULT_GOAL := help
CURRENT_FOLDER=$(shell basename "$$(pwd)")
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
RESET=$(shell tput sgr0)

help:
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
	@echo "Install dependencies"
	@echo "Done"

uninstall: ## Uninstall dependencies
	@echo "Uninstall dependencies"
	@echo "Done"
