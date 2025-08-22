terraform {
  required_version = ">= 0.15.4"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.8.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.4.1"
    }
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.65"
    }
  }
}
