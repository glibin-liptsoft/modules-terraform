resource "yandex_iam_service_account" "registry" {
  name = "registry"
}

module "cr" {
  source = "../../"

  registry = "test"

  roles = [
    {
      role = "container-registry.viewer"
      members = ["system:allUsers"]
    }
  ]

  repos = {
    "frontend" = {
      role = "pusher"
      members = [
        "serviceAccount:${yandex_iam_service_account.registry.id}"
      ]
      lifecycle_policy_name         = "frontend-cleanup-policy"
      lifecycle_policy_status       = "active"
      lifecycle_policy_description  = "Describtion policy"
      lifecycle_policy = [{
        description  = "Cleanup policy for frontend images"
        expire_period = "168h"  # 7 дней
        untagged     = true
        tag_regexp   = ".*"
        retained_top = 5
      },
      {
        description  = "Cleanup policy for frontend images"
        expire_period = "168h"  # 7 дней
        untagged     = true
        tag_regexp   = ".*"
        retained_top = 5
      }]
    },
    "worker" = {
      role = ""
      members = [
        "system:allUsers"
      ]
      lifecycle_policy_name         = "worker-cleanup-policy"
      lifecycle_policy_status       = "active"
      lifecycle_policy_description  = "Describtion policy"
      lifecycle_policy = [{
        description  = "Cleanup policy for worker images"
        expire_period = "24h"   # 1 день
        untagged     = true
        tag_regexp   = "latest"
        retained_top = 1
      }]
    }
  }

}
