# goexpert-k8s


## Modo de uso
``` shell
### local, usando docker-compose
make compose_up
make run

### kubernetes
make cluster_up
make build
make deploy
NODE_ADDRESS=$(shell kubectl get node goexpert-k8s-control-plane -o jsonpath="{.status.addresses[0].address}")
NODE_PORT=$(kubectl get svc server-svc -o jsonpath="{.spec.ports[0].nodePort}")
curl ${NODE_ADDRESS}:${NODE_PORT}/status
curl ${NODE_ADDRESS}:${NODE_PORT}/hello/$(whoami)
make cluster_down
```
