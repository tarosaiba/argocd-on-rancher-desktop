# Install ArgoCD

We need to make changes to the [install.yaml](https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml) provided by ArgoCD to use it.
`argocd-server` needs to run in insecure mode, so that we can access the ArgoCD UI via HTTP communication on the local Rancher Desktop environment. This allows you to access the ArgoCD UI screen.

```yaml:argocd-install.yaml
apiVersion: apps/v1
kind: Deployment
  name: argocd-server
spec:
[..]
    containers:
      - command:
        - argocd-server
+       - --insecure       # Added line
```
