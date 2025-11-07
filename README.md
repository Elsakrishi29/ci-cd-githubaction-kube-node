# ci-cd-githubaction-kube-node

## Local test (before pushing workflow)

```bash
# Build locally:
docker build -t local-myapp:dev .
docker run --rm -p 3000:3000 local-myapp:dev
# check http://localhost:3000

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