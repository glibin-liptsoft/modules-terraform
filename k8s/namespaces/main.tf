resource "kubernetes_namespace" "namespace" {
  for_each = var.namespaces

  metadata {
    name = each.key

    labels = merge(
      try(each.value.labels, {}),
      {
        "name" = each.key,
        "terraform-managed" = "true"
      }
    )

    annotations = merge(
      try(each.value.annotations, {}),
      {
        "terraform.io/module" = "kubernetes-namespaces"
      }
    )
  }
}

resource "kubernetes_resource_quota" "quota" {
  for_each = { for k, v in var.namespaces : k => v if try(v.resource_quota, null) != null }

  metadata {
    name      = "${each.key}-quota"
    namespace = kubernetes_namespace.namespace[each.key].metadata[0].name
  }

  spec {
    hard = each.value.resource_quota
  }
}

resource "kubernetes_limit_range" "limit_range" {
  for_each = { for k, v in var.namespaces : k => v if try(v.limit_range, null) != null }

  metadata {
    name      = "${each.key}-limits"
    namespace = kubernetes_namespace.namespace[each.key].metadata[0].name
  }

  spec {
    dynamic "limit" {
      for_each = each.value.limit_range
      content {
        type = limit.key
        default = try(limit.value.default, null)
        default_request = try(limit.value.default_request, null)
        max = try(limit.value.max, null)
        min = try(limit.value.min, null)
        max_limit_request_ratio = try(limit.value.max_limit_request_ratio, null)
      }
    }
  }
}