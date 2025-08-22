resource "kubernetes_namespace" "this" {
  metadata {
    name   = var.name
    labels = var.ns_labels
  }
}

resource "helm_release" "this" {
  name       = var.name
  chart      = "${path.module}/helm-chart"
  namespace  = var.name

  values = [
    local.helm_values,
    try(var.custom_helm_values)
  ]

  depends_on = [
    kubernetes_namespace.this
  ]
}

locals {
  helm_values = templatefile("${path.module}/argo-cd.tftpl", {
    argocd_domain             = var.argocd_domain
    argocd_tag                = var.argocd_tag
    argocd_admin_password     = var.argocd_admin_password
    argocd_repositories       = var.argocd_repositories
    argocd_ingress_annot      = var.argocd_ingress_annot
    argocd_ingress_class      = var.argocd_ingress_class
    argocd_ingress_tls        = var.argocd_ingress_tls
  })
}
