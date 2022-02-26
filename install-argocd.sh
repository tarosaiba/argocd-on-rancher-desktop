#!/bin/bash

# Set up Argo CD
## Create Namespace
kubectl apply -f ./argocd-infra/namespace.yaml
## Install Argo
kubectl apply -n argocd -f ./argocd-infra/install.yaml
## Create Ingress for server
kubectl apply -n argocd -f ./argocd-infra/ingress.yaml

# Deploy application by using Argo CD
kubectl apply -f ./argocd
