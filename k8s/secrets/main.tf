resource "kubernetes_secret_v1" "secret" {
  for_each = {
    for secret in local.expanded_secrets :
    "${secret.namespace}/${secret.name}" => secret
  }

  metadata {
    name      = each.value.name
    namespace = each.value.namespace
    labels    = try(each.value.labels, {})
    annotations = try(each.value.annotations, {})
  }

  data = try(each.value.data, {})
  binary_data = try(each.value.binary_data, {})

  type = try(each.value.type, "Opaque")
  immutable = try(each.value.immutable, false)
}

locals {
  # Expand single secret definition to multiple namespaces
  expanded_secrets = flatten([
    for secret in var.secrets : [
      for ns in secret.namespaces : {
        name        = secret.name
        namespace   = ns
        type        = try(secret.type, "Opaque")
        data        = try(secret.data, {})
        binary_data = try(secret.binary_data, {})
        labels      = try(secret.labels, {})
        annotations = try(secret.annotations, {})
        immutable   = try(secret.immutable, false)
      }
    ]
  ])
}