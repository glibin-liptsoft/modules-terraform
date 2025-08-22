# Kubernetes Namespaces Terraform Module

This module creates and manages Kubernetes namespaces with optional resource quotas and limit ranges.

## Features

- Creates Kubernetes namespaces
- Supports labels and annotations
- Optional resource quotas
- Optional limit ranges
- Terraform-managed labeling

## Usage

```hcl
module "namespaces" {
  source = "./modules/kubernetes-namespaces"

  namespaces = {
    "production" = {
      labels = {
        "environment" = "production"
        "tier"        = "backend"
      },
      annotations = {
        "owner" = "platform-team"
      },
      resource_quota = {
        "requests.cpu"    = "20"
        "requests.memory" = "100Gi"
        "limits.cpu"      = "40"
        "limits.memory"   = "200Gi"
        "pods"            = "100"
      },
      limit_range = {
        "Container" = {
          default = {
            cpu    = "500m"
            memory = "1Gi"
          }
          default_request = {
            cpu    = "200m"
            memory = "512Mi"
          }
          max = {
            cpu    = "2"
            memory = "4Gi"
          }
        }
      }
    },
    "staging" = {
      labels = {
        "environment" = "staging"
      }
    }
  }
}