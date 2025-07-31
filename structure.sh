#!/bin/bash

mkdir -p devops-python-app/k8s/{base,overlays/{dev/rbac,staging/rbac},argocd/{applications,ingress},middleware,tls}

# Base files
touch devops-python-app/k8s/base/{deployment.yaml,service.yaml,ingressroute.yaml}

# Dev overlay
touch devops-python-app/k8s/overlays/dev/{kustomization.yaml,configmap.yaml,ingressroute.yaml}
touch devops-python-app/k8s/overlays/dev/rbac/{role.yaml,rolebinding.yaml}

# Staging overlay
touch devops-python-app/k8s/overlays/staging/{kustomization.yaml,configmap.yaml,ingressroute.yaml}
touch devops-python-app/k8s/overlays/staging/rbac/{role.yaml,rolebinding.yaml}

# ArgoCD apps and ingress
touch devops-python-app/k8s/argocd/applications/{dev.yaml,staging.yaml}
touch devops-python-app/k8s/argocd/ingress/argocd-ingressroute.yaml

# Middleware & TLS
touch devops-python-app/k8s/middleware/argocd-ip-whitelist.yaml
touch devops-python-app/k8s/tls/argocd-cert.yaml

# Optional project README
touch devops-python-app/README.md

echo "✅ Folder structure created!"
