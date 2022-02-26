#!/bin/bash

# Set up Argo CD
## Create Namespace
kubectl apply -f ./infra/argocd-namespace.yaml
## Install Argo
kubectl apply -n argocd -f ./infra/argocd-install.yaml
## Create Ingress for argocd-server
kubectl apply -n argocd -f ./infra/argocd-ingress.yaml

# Deploy application by using Argo CD
kubectl apply -f ./argocd
