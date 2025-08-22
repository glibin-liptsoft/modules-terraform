variable "name" {
  type        = string
  description = "Name of gitlab-runner"
}

variable "ns_labels" {
  type        = map(string)
  description = "Map with labels for k8s namespace"
  default = {}
}

variable "custom_helm_values" {
  type        = string
  default     = ""
  description = "Custom YAML helm values"
}

variable "folder_id" {
  type        = string
  description = "folder id where exist dns zone on yandex cloud"
}

variable "sa_prefix" {
  type        = string
  description = "Prefix for ServiceAccount"
}

variable "zones" {
  type        = list(string)
  default     = []
  description = "use only ths id dns zone on yandex cloud"
}

