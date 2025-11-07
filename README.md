# ci-cd-githubaction-kube-node

## Local test (before pushing workflow)

```bash
# Build locally:
docker build -t ci-cd-myapp:latest .
docker run --rm -p 5000:5000 ci-cd-myapp:latest

docker tag ci-cd-myapp:latest krishnaveni29/ci-cd-myapp:latest
docker push krishnaveni29/ci-cd-myapp:latest
# check http://localhost:3000

# Deployment YAML k8s/deployment.yaml
# Service YAML k8s/service.yaml

kubectl get nodes
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

kubectl get pods
kubectl get svc

# Run the app
minikube service myapp-svc
(OR)
curl http://192.168.49.2:32228 
(OR)
curl $(minikube ip):32228

git config --global user.name "Elsakrishi29"
ssh-keygen -t ed25519 -C "krishveni2902@gmail.com"

https://github.com/Elsakrishi29/ci-cd-githubaction-kube-node/settings/actions/runners/new

# Test with Minikube locally:

# make minikube use its own docker
eval $(minikube -p minikube docker-env)
docker build -t yourdockerhubuser/myapp:localtest .
# apply manifests (update image tag if needed)
kubectl apply -f k8s/
kubectl set image deployment/myapp myapp=yourdockerhubuser/myapp:localtest
kubectl get pods
minikube service myapp-svc --url

```

## Using gh CLI 

```bash
# To use the access token from your Docker CLI client

# 1. Run

# replace with your username and token (or use env var)


# Using GitHub UI

# Repo → Settings → Secrets & variables → Actions → New repository secret

# Name: DOCKERHUB_USERNAME → value: your-dockerhub-username

# Name: DOCKERHUB_TOKEN → value: paste the token you copied from Docker Hub

# Using gh CLI

gh secret set DOCKERHUB_USERNAME --body "krishnaveni29"
gh secret set DOCKERHUB_TOKEN --body "$(cat ~/secrets/dockerhub_token.txt)"   # or paste token
# set IMAGE_NAME if you want to use secret; in our workflow IMAGE was env=krish/myapp already

# create base64 kubeconfig and set secret
cat ~/.kube/config | base64 | tr -d '\n' | gh secret set KUBE_CONFIG_DATA --body -
```