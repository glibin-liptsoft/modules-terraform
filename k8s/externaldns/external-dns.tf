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
  set = [
    {
      name  = "config.folder_id"
      value = "${var.folder_id}"
    }
  ]
  set_sensitive = [
    {
      name  = "config.auth.json"
      value = "${base64encode(module.sa-external-dns.service_account_keys.externaldns.json_key)}"
    }
  ]
  set_list = [
    {
      name  = "config.zones"
      value = var.zones
    }
  ]

  depends_on = [
    kubernetes_namespace.this,
    module.sa-external-dns
  ]
}

