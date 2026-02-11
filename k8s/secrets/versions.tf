terraform {
  required_version = ">= 0.15.4"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.8.0, < 3.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.0, < 4.0.0"
    }
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.65, < 1.0"
    }
  }
}
