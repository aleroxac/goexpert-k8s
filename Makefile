## ---------- UTILS
.PHONY: help
help: ## Show this menu
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: clean
clean: ## Clean all temp files
	@rm -rf tmp/



## ---------- COMPOSE
.PHONY: compose_up
compose_up: ## Run docker-compose up
	@docker-compose up -d
	@docker-compose exec -it app bash

.PHONY: compose.down
compose_down: ## Run docker-compose down
	@docker-compose down



## ---------- KIND
.PHONY: cluster_up
cluster_up: ## Put the kind cluster up
	@kind create cluster --name goexpert-k8s
	@kubectl cluster-info --context kind-goexpert-k8s
	@kubectl create namespace goexpert
	@kubectl config set-context kind-goexpert-k8s --namespace goexpert

.PHONY: cluster_down
cluster_down: ## Put the kind cluster down
	@kind delete cluster --name goexpert-k8s



## ---------- MAIN
.PHONY: build
build: ## Build the container image
	@docker build -t aleroxac/goexpert-k8s:v1 -f Dockerfile.prd .
	@docker push aleroxac/goexpert-k8s:v1

.PHONY: deploy
deploy: ## Deploy app on kubernetesm
	@kubectl apply -f k8s/app.yaml


.PHONY: run
run: ## Run the code locally
	@go run main.go