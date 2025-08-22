variable "name" {
  type        = string
  description = "Name of cert-manager, used for ServiceAccount name, namespace, helm, etc"
}

variable "description" {
  type        = string
  description = "Description of the ServiceAccount in yc"
  default     = null
}

variable "folder_id" {
  type        = string
  description = "Target to folder, to create DNS-records for cert-manager"
}

variable "sa_prefix" {
  type        = string
  description = "Prefix for ServiceAccount"
}

variable "cert_manager_webhook_yandex_chart_values" {
  type        = string
  description = "cert-manager-webhook-yandex helm chart values"
  default     = <<HELM
    cert-manager:
        installCRDs: false
        podDnsConfig:
            nameservers:
            - "1.1.1.1"
            - "8.8.8.8"
        dns01RecursiveNameservers: "8.8.8.8:53,1.1.1.1:53"
        dns01RecursiveNameserversOnly: true
HELM
}

variable "acme" {
  type = map(object({
    folder_id = string,
    server    = string,
    email     = string,
    eab       = optional(object({
      key_id   = string,
      hmac_key = string
    }))
  }))
  description = "ACME registration configuration"
}
