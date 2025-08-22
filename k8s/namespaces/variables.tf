variable "namespaces" {
  description = "Map of namespaces to create with their configuration"
  type = map(object({
    labels      = optional(map(string))
    annotations = optional(map(string))
    resource_quota = optional(map(string))
    limit_range = optional(map(any))
  }))
  default = {}
}