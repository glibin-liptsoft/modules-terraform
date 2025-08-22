# modules/kubernetes-secrets/variables.tf

variable "secrets" {
  description = "List of secrets to create with their target namespaces"
  type = list(object({
    name        = string
    namespaces  = list(string)
    type        = optional(string)
    data        = optional(map(string))
    binary_data = optional(map(string))
    labels      = optional(map(string))
    annotations = optional(map(string))
    immutable   = optional(bool)
  }))
  validation {
    condition     = length(var.secrets) > 0
    error_message = "At least one secret must be defined."
  }
}

variable "namespace_labels" {
  description = "Labels to check for in target namespaces (optional validation)"
  type        = map(string)
  default     = {}
}

variable "require_namespace_existence" {
  description = "Whether to verify namespaces exist before creating secrets"
  type        = bool
  default     = true
}