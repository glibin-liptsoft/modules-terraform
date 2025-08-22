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

  set_sensitive = [
    {
      name  = "secret.accessKey"
      value = "${yandex_iam_service_account_static_access_key.default.access_key}"
    },
    {
      name  = "secret.secretKey"
      value = "${yandex_iam_service_account_static_access_key.default.secret_key}"
    }
  ]

  set = [
    {
      name  = "storageClass.singleBucket"
      value = "${try(yandex_storage_bucket.default[0].id, "")}"
    }
  ]
  
  values = [
    try(var.custom_helm_values),
  ]

  depends_on = [
    kubernetes_namespace.this,
    yandex_iam_service_account.default,
    yandex_resourcemanager_folder_iam_member.default,
    yandex_iam_service_account_static_access_key.default,
    yandex_storage_bucket.default
  ]
}
