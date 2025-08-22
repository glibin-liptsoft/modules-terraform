variable "folder_id" {
  type        = string
  default     = ""
  description = "id folder in cloud"
}

variable "name" {
  type        = string
  description = "Name of release, namespace and sa"
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

variable "sa_prefix" {
  type        = string
  description = "Prefix for ServiceAccount"
}


variable "single_bucket" {
  type        = bool
  default     = true
  description = "use singl bucket for all pvc"
}

variable "max_size" {
  type        = number
  default     = 1000000000 # ~ 1Гб
  description = "max size created bucket"
}

