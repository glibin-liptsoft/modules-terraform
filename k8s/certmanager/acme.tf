resource "yandex_iam_service_account" "this" {
  for_each = var.acme

  name      = "${var.sa_prefix}-${each.key}"
  folder_id = each.value.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "this" {
  for_each = var.acme

  folder_id = each.value.folder_id
  role      = "dns.editor"
  member    = "serviceAccount:${yandex_iam_service_account.this[each.key].id}"

  depends_on = [
    yandex_iam_service_account.this
  ]
}

resource "yandex_iam_service_account_key" "this" {
  for_each = var.acme

  service_account_id = yandex_iam_service_account.this[each.key].id
  description        = var.description
  key_algorithm      = "RSA_4096"
  depends_on = [
    yandex_iam_service_account.this
  ]
}

resource "kubernetes_secret" "this" {
  for_each = var.acme

  metadata {
    name      = "${each.key}-sa"
    namespace = kubernetes_namespace.this.metadata[0].name
  }

  type = "Opaque"

  data = {
    "iamkey.json" = <<SA-KEY-JSON
{
  "id": "${yandex_iam_service_account_key.this[each.key].id}",
  "service_account_id": "${yandex_iam_service_account.this[each.key].id}",
  "created_at": "${yandex_iam_service_account_key.this[each.key].created_at}",
  "key_algorithm": "RSA_4096",
  "public_key": ${jsonencode(yandex_iam_service_account_key.this[each.key].public_key)},
  "private_key": ${jsonencode(yandex_iam_service_account_key.this[each.key].private_key)}
}
SA-KEY-JSON
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_member.this,
    yandex_iam_service_account_key.this
  ]
}

resource "kubernetes_secret" "eab" {
  for_each = local.acme_with_eab

  metadata {
    name      = each.key
    namespace = kubernetes_namespace.this.metadata[0].name
  }

  type = "Opaque"

  data = {
    "secret" = "${each.value.eab.hmac_key}"
  }
}

resource "helm_release" "acme-with-eab" {
  for_each = local.acme_with_eab

  name       = each.key
  repository = "https://helm-charts.wikimedia.org/stable"
  chart      = "raw"
  version    = "0.3.0"
  namespace  = kubernetes_namespace.this.metadata[0].name

  values = [templatefile("${path.module}/acme.tpl", {
    name           = each.key,
    email          = each.value.email,
    server         = each.value.server,
    folder_id      = each.value.folder_id,
    serviceAccount = kubernetes_secret.this["${each.key}"].metadata[0].name,
    tls_key        = "${each.key}-tls"
    key_id         = each.value.eab.key_id,
    key_secret     = kubernetes_secret.eab["${each.key}"].metadata[0].name
  })]

  depends_on = [
    kubernetes_secret.this,
    kubernetes_secret.eab,
    helm_release.cert-manager-webhook-yandex
  ]
}

resource "helm_release" "acme-without-eab" {
  for_each = local.acme_without_eab

  name       = each.key
  repository = "https://helm-charts.wikimedia.org/stable"
  chart      = "raw"
  version    = "0.3.0"
  namespace  = kubernetes_namespace.this.metadata[0].name

  values = [templatefile("${path.module}/acme.tpl", {
    name           = each.key,
    email          = each.value.email,
    server         = each.value.server,
    folder_id      = each.value.folder_id,
    serviceAccount = kubernetes_secret.this["${each.key}"].metadata[0].name,
    tls_key        = "${each.key}-tls"
    key_id         = "",
    key_secret     = ""
  })]

  depends_on = [
    kubernetes_secret.this,
    helm_release.cert-manager-webhook-yandex
  ]
}
