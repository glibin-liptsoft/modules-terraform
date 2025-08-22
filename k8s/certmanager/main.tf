resource "kubernetes_namespace" "this" {
  metadata {
    name = var.name
  }
}

resource "helm_release" "cert-manager-webhook-yandex" {
  name      = "${var.name}-yandex"
  repository  = "oci://cr.yandex/yc-marketplace/yandex-cloud/cert-manager-webhook-yandex/helm"
  chart       = "cert-manager-webhook-yandex"
  version     = "1.0.7"
  namespace = kubernetes_namespace.this.metadata[0].name

  values = [var.cert_manager_webhook_yandex_chart_values]

  depends_on = [
    kubernetes_namespace.this
  ]
}