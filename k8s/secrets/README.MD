# Kubernetes Secrets Terraform Module

This module creates Kubernetes secrets of different types.

## Features

- Creates generic (Opaque) secrets
- Creates Docker registry secrets
- Supports labels and annotations
- Configurable secret types
- Optional immutable flag for generic secrets

## Usage

```hcl
module "secrets" {
  source = "./modules/kubernetes-secrets"

  generic_secrets = {
    "db-credentials" = {
      namespace = "default"
      data = {
        "username" = base64encode("admin")
        "password" = base64encode("secret")
      }
      labels = {
        "app" = "database"
      }
    }
  }

  docker_registry_secrets = {
    "docker-hub" = {
      namespace = "default"
      registry  = "https://index.docker.io/v1/"
      username  = "dockeruser"
      password  = "dockerpass"
      email     = "user@example.com"
    }
  }
}