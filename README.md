This repository contains the source files needed to follow the series [Kubernetes and everything else](https://rinormaloku.com/series/kubernetes-and-everything-else/) or summarized as an article in [Learn Kubernetes in Under 3 Hours: A Detailed Guide to Orchestrating Containers](https://medium.freecodecamp.org/learn-kubernetes-in-under-3-hours-a-detailed-guide-to-orchestrating-containers-114ff420e882)

To learn more about Kubernetes and other related topics check the following examples with the **Sentiment Analysis** application:

* [Kubernetes Volumes in Practice](https://rinormaloku.com/kubernetes-volumes-in-practice/):
* [Ingress Controller - simplified routing in Kubernetes](https://www.orange-networks.com/blogs/210-ingress-controller-simplified-routing-in-kubernetes)
* [Docker Compose in Practice](https://github.com/rinormaloku/k8s-mastery/tree/docker-compose)
* [Istio around everything else series](https://rinormaloku.com/series/istio-around-everything-else/)
* [Simple CI/CD for Kubernetes with Azure DevOps](https://www.orange-networks.com/blogs/224-azure-devops-ci-cd-pipeline-to-deploy-to-kubernetes)
* Envoy series - to be added!


## Development Workflow Setup

### Minikube

Setup
```bash
minikube start
skaffold dev ## Ensure you have a dockerfile and ensure you have a deployment.yaml in k8s/ folder
```


# Build and Deploy

## Deployment
Login to docker (if not logged in)
```bash
DOCKER_USERNAME=''
DOCKER_PASSWORD=''
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
```

Allow the deployment script to be executable
```bash
chmod +x ./deploy.sh
```

Set your docker username and then execute deployment script
```bash
./deploy.sh --uid 'aojabariholder'
```

## Setup of Kubernetes

Install Minikube
```bash
brew install minikube
```

Start cluster
```bash
minikube start
```

See available nodes
```bash
kubectl get nodes
```

See available services (pending won't change locally run - minikube service sa-frontend-lb)
```bash
kubectl get svc
```

View dashboard
```bash
minikube dashboard
```

Startup Serivce - Main
```bash
kubectl apply -f sa-frontend-deployment.yaml
kubectl create -f service-sa-frontend-lb.yaml
minikube service sa-frontend-lb

```

Start deployment
```bash
kubectl apply -f sa-frontend-deployment.yaml  --record
```

Start pod
```bash
kubectl create -f sa-frontend-pod.yaml
kubectl create -f service-sa-frontend-lb.yaml  # for cloud deployment
```

See available pods (add watch to wait until it's started)
```bash
kubectl get pods --watch
```

Exposing the pod for external use
```bash
kubectl port-forward sa-frontend 88:80
```

Update existing pods with new config
```bash
kubectl apply -f sa-frontend-pod.yaml
```

SSH into pod
```bash
kubectl exec -it sa-frontend -- /bin/bash
```

Delete Pod
```bash
kubectl delete pod sa-frontend
```

View labeled pods
```bash
kubectl get pod -l app=sa-frontend
```

## Ksync
Allow live reload

Installation
```bash
curl https://ksync.github.io/gimme-that/gimme.sh | bash
```

## Skaffold
Continuous deployment

Installation
```bash
brew install skaffold
```

##  Extra
```bash
kubectl config use-context minikube ## Change kubectrl context to minikube.
eval $(minikube docker-env) ## set the docker client to use minikube
```