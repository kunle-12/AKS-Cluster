# AKS-Cluster
# AKS-Cluster
# AKS-Cluster
```text```

terraform-aks-platform/
├── envs/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── backend.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       ├── backend.tf
│       └── terraform.tfvars
└── modules/
    ├── resource_group/
    ├── network/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── acr/
    ├── aks/
    └── argocd_bootstrap/   # optional module to install ArgoCD via Helm
