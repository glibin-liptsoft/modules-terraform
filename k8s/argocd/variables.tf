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

variable "argocd_domain" {
  type        = string
  description = "domain argocd and hostname for ingress"
}

variable "argocd_tag" {
  type        = string
  default     = "v2.14.7"
  description = "tag image argocd server"
}

variable "argocd_admin_password" {
  type        = string
  default     = "$2a$10$N2FA.D/oz4MDAgmSgLCUCem2a3m8kq.vCKUnTATJYjeDvpXRjBg5u"
  description = <<-EOF
  Default admin password (argopass).
  Generate new: `htpasswd -nbBC 10 "" $ARGO_PWD | tr -d ':\n' | sed 's/$2y/$2a/'`
  EOF
}

variable "argocd_repositories" {
  type        = string
  description = "repositories added in argocd"
  default     = <<EOF
    helm-victoriametrics:
      type: helm
      name: victoriametrics
      url: https://victoriametrics.github.io/helm-charts/
      project: infrastructure
    helm-gitlab:
      type: helm
      name: gitlab
      url: https://charts.gitlab.io/
      project: infrastructure
  EOF 
}

variable "argocd_ingress_annot" {
  type        = string
  default     = ""
  description = "Annotaion for ingress"
}

variable "argocd_ingress_class" {
  type        = string
  description = "IngressClassName for ingress ArgoCD"
}

variable "argocd_ingress_tls" {
  type        = string
  default     = "false"
  description = "Enable TLS on ingress ArgoCD"
}