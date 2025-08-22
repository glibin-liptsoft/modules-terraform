resource "kubernetes_namespace" "this" {
  metadata {
    name   = var.name
    labels = var.ns_labels
  }
}

locals {
  helm_values = templatefile("${path.module}/ingress-controller.tftpl", {
    ingress_class             = var.ingressClass
    load_balancer_ip          = var.loadBalancerIP
    load_balancer_annotations = var.loadBalancerAnnotations
    enable_real_ip            = var.enableRealIp
    use_forwarded_headers     = var.useForwardedHeaders
    use_proxy_protocol        = var.useProxyProtocol
    proxy_real_ip_cidrs       = var.proxyRealIpCidrs
    allow_snippet_annotations = var.allowSnippetAnnotations
    default_backend_override  = var.default_backend_override
    ingress_replicas_count    = var.ingress_replicas_count
    ingress_controller_kind   = var.ingress_controller_kind
    metrics_service_conf      = var.metricsServiceConf
    tolerations               = var.tolerations
    affinity                  = var.affinity
    extra_update_status       = var.extra_update_status
    enable_nexus_maps         = var.enable_nexus_maps
    proxy_connect_timeout     = var.proxy_connect_timeout
    proxy_read_timeout        = var.proxy_read_timeout
    proxy_send_timeout        = var.proxy_send_timeout
    log_format_upstream       = var.log_format_upstream
    custom_http_errors        = var.custom_http_errors
  })
}

resource "helm_release" "this" {
  name       = var.name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.ingressNginxChartVersion
  namespace  = var.name

  values = [
    local.helm_values,
    try(var.custom_helm_values),
  ]

  depends_on = [
    kubernetes_namespace.this
  ]
}
