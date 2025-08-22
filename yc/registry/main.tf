data "yandex_client_config" "client" {}
# locals {
#   #repos_roles = concat([for k, v in var.repos:  {for idx, role in v.roles: "${k}-${idx}" => role}])
#   #result = concat([for val in local.repos_roles: val])
# }

###########
## Registry
###########
resource "yandex_container_registry" "this" {
  name      = var.registry
  folder_id = data.yandex_client_config.client.folder_id

  labels = var.labels == null ? { project = var.registry } : var.labels
}

resource "yandex_container_registry_iam_binding" "this" {
  for_each    = { for idx, val in var.roles : idx => val }
  registry_id = yandex_container_registry.this.id
  role        = each.value.role
  members     = each.value.members
}

#############
## Repository
#############
resource "yandex_container_repository" "this" {
  for_each = var.repos
  name     = "${yandex_container_registry.this.id}/${each.key}"
}

resource "yandex_container_repository_iam_binding" "this" {
  for_each = { for name, value in var.repos : name => value if value.role != "" }

  repository_id = yandex_container_repository.this[each.key].id
  role          = "container-registry.images.${lookup(each.value, "role", "puller")}"
  members       = lookup(each.value, "members", ["system:allUsers"])
}


resource "yandex_container_repository_lifecycle_policy" "this" {
  for_each = var.repos

  name          = each.value.lifecycle_policy_name
  status        = each.value.lifecycle_policy_status
  description   = each.value.lifecycle_policy_description
  repository_id = yandex_container_repository.this[each.key].id

  dynamic "rule" {
    for_each = each.value.lifecycle_policy
    content {
      description   = rule.value.description
      expire_period = rule.value.expire_period
      untagged      = rule.value.untagged
      tag_regexp    = rule.value.tag_regexp
      retained_top  = rule.value.retained_top
    }
  }
}
