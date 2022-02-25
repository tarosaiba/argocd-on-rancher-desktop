#!/bin/bash
###################################################
# Add environment
# * generate new folder by copying env01
#
# ##################################################

###################################################
# Help
###################################################
show_help() {
  cat <<EOF
Usage: ${0##*/} -n <ENV_NAME>
Do something test in each directory.
Options:
    -n ENV_NAME    (Environment name = namespace)
Examples:
    ${0##*/} -n env02
EOF
}



###################################################
# Main Function
###################################################
## Arg valiable
env_name=""

## Arg set
OPTIND=1
while getopts "hn:" opt; do
  case "$opt" in
    h) show_help; exit 0 ;;
    n) env_name="$OPTARG" ;;
    *) echo "Unhandled option: -$opt" >&2: show_help >&2: exit 1 ;;
  esac
done

## Arg checks
if [[ -z "${env_name}" ]]; then
  echo "ERROR: env_name must be set."
  show_help >&2
  exit 1
fi

## Copy Folder
copy_from="./deploy/overlays/env01"
copy_to="./deploy/overlays/${env_name}"

if [ -e ${copy_to} ]; then
   echo "[ERROR] ${copy_to} already exists!"
   exit 1;
else
   cp -r ${copy_from} ${copy_to}
fi

echo "[INFO] ${copy_to} folder generated and files were copied"

## Sed
find ${copy_to} -type f | xargs sed -i "" "s/env01/${env_name}/"
echo "[INFO] files in ${copy_to} were replaced env01 -> ${env_name}"


## Add Namespace
cat << EOF >>./argocd/namespace.yaml

---
apiVersion: v1
kind: Namespace
metadata:
  name: ${env_name}
EOF
echo "[INFO] namespace ${env_name} was added"


## Add argocd setting
cat << EOF >>./argocd/application.yaml

---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: gitops-demo-${env_name}
  namespace: argocd
  labels:
    environment: ${env_name}
spec:
  project: gitops-demo
  destination:
    namespace: ${env_name}
    server: https://kubernetes.default.svc
  source:
    kustomize:
    path: deploy/overlays/${env_name}
    repoURL: https://github.com/tarosaiba/gitops-demo-local.git
    targetRevision: main
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - ApplyOutOfSyncOnly=true
EOF
echo "[INFO] argocd Application gitops-demo-${env_name} is added"
