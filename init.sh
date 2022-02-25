#!/bin/bash

## Create Namespace
kubectl apply -f ./infra
## Install Argo
kubectl apply -n argocd -f ./infra/argocd-install.yaml
