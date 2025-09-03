variable "registry" {
  description = "Container registry name"
  type        = string
}

variable "labels" {
  description = "Container registry labels"
  type        = map(string)
  default     = {}
}

# see https://cloud.yandex.com/en/docs/container-registry/security/
variable "roles" {
  description = "The role that should be applied"
  type = list(object({
    role    = optional(string)
    members = optional(list(string))
  }))
  default = []
}

variable "repos" {
  description = "Repositories with role binding and lifecycle_policy"
  type        = map(any)
  default     = {}
}

variable "ip_permission" {
  description = "Repositories with role binding and lifecycle_policy"
  type        = object({
    push = optional(list(string))
    pull = optional(list(string))
  })
  default     = {
    push = []
    pull = []
  }
}