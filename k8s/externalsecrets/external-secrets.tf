resource "kubernetes_namespace" "this" {
  metadata {
    name   = var.name
    labels = var.ns_labels
  }
}

resource "helm_release" "this" {
  name       = var.name
  chart      = "${path.module}/helm-chart"
  namespace  = var.name

  values = [
    try(var.custom_helm_values),
  ]
  set_sensitive = [
    {
      name  = "auth.json"
      value = "${base64encode(module.sa-external-secret.service_account_keys.externalsecret.json_key)}"
    }
  ]

  depends_on = [
    kubernetes_namespace.this,
    module.sa-external-secret
  ]
}

resource "time_sleep" "wait_10_seconds" {
  create_duration = "10s"
  depends_on = [
    kubernetes_namespace.this,
    module.sa-external-secret,
    helm_release.this
  ]
}

resource "kubernetes_manifest" "cluster_secret_store_yandexlockbox" {
  count = var.cluster_secret_store_yandexlockbox ? 1 : 0
  depends_on = [
    kubernetes_namespace.this,
    module.sa-external-secret,
    helm_release.this,
    time_sleep.wait_10_seconds
  ]
  manifest = {
    "apiVersion" = "external-secrets.io/v1beta1"
    "kind"       = "ClusterSecretStore"
    "metadata" = {
      "name"      = "secret-store-yandexlockbox"
    }
    "spec" = {
      "provider" = {
        "yandexlockbox" = {
          "auth" = {
            "authorizedKeySecretRef" = {
              "namespace" = "${var.name}"
              "name" = "sa-creds"
              "key" = "key"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_manifest" "cluster_secret_store_yandexcertificatemanager" {
  count = var.cluster_secret_store_yandexcertificate ? 1 : 0
  depends_on = [
    kubernetes_namespace.this,
    module.sa-external-secret,
    helm_release.this,
    time_sleep.wait_10_seconds
  ]
  manifest = {
    "apiVersion" = "external-secrets.io/v1beta1"
    "kind"       = "ClusterSecretStore"
    "metadata" = {
      "name"      = "secret-store-yandexcertificatemanager"
    }
    "spec" = {
      "provider" = {
        "yandexcertificatemanager" = {
          "auth" = {
            "authorizedKeySecretRef" = {
              "namespace" = "${var.name}"
              "name" = "sa-creds"
              "key" = "key"
            }
          }
        }
      }
    }
  }
}