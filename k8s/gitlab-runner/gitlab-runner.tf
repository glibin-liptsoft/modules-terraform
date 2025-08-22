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
    try(var.custom_helm_values),
  ]

  depends_on = [
    kubernetes_namespace.this
  ]
}

locals {
  helm_values = templatefile("${path.module}/gitlab-runner.tftpl", {
    tolerations               = var.tolerations
    affinity                  = var.affinity
    concurrent                = var.gitlab_runner_concurrent
    gitlab_url                = var.gitlab_url
    gitlab_token              = var.gitlab_token
    gitlab_runner_registry    = var.gitlab_runner_image.registry
    gitlab_runner_image       = var.gitlab_runner_image.image
    gitlab_runner_tag         = var.gitlab_runner_image.tag
    cpu_lim = var.runner_config.cpu_lim
    cpu_req = var.runner_config.cpu_req
    mem_lim = var.runner_config.mem_lim
    mem_req = var.runner_config.mem_req
    image = var.runner_config.image
    help_cpu_lim = var.runner_config.help_cpu_lim
    help_cpu_req = var.runner_config.help_cpu_req
    help_mem_lim = var.runner_config.help_mem_lim
    help_mem_req = var.runner_config.help_mem_req
    help_image   = var.runner_config.help_image
    rbac_rules = var.rbac_rules
    service_account = var.name


  })
}

