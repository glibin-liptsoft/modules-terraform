variable "name" {
  type        = string
  description = "Name of ingress-nginx"
}

variable "ingressNginxChartVersion" {
  type        = string
  description = "ingress-nginx helm chart version"
  default     = "4.12.1"
}

variable "loadBalancerIP" {
  type        = string
  description = "IP address for creating LoadBalancer with NLB, on k8s"
}

variable "loadBalancerAnnotations" {
  type        = map(any)
  description = "annotations for creating LoadBalancer with NLB"
  default     = null
}

variable "ingressClass" {
  type        = string
  description = "Default ingress class for nginx"
  default     = "nginx"
}

variable "enableRealIp" {
  type    = string
  default = "false"
}

variable "useForwardedHeaders" {
  type    = string
  default = "false"
}

variable "useProxyProtocol" {
  type    = string
  default = "false"
}

variable "proxyRealIpCidrs" {
  type    = string
  default = null
}

variable "default_backend_override" {
  type    = bool
  default = false
}

variable "custom_http_errors" {
  type    = string
  default = null
  description = "list err cod which redirect custom err page, must default_backend_override=true"
}

variable "allowSnippetAnnotations" {
  type    = bool
  default = false
}

variable "enable_nexus_maps" {
  type    = bool
  default = false
}

variable "ns_labels" {
  type        = map(string)
  description = "Map with labels for k8s namespace"
  default = {
    "vector.enabled" = "true"
    "vector.format"  = "json"
  }
}

variable "ingress_replicas_count" {
  type    = number
  default = 1
}

variable "ingress_controller_kind" {
  type    = string
  default = "Deployment"
}

variable "metricsServiceConf" {
  type = object({
    type           = string
    annotations    = map(any)
    loadBalancerIP = string
  })
  description = "k8s service settings for nginx metrics"
  default     = null
}

variable "tolerations" {
  description = <<EOF
    Node tolerations for server scheduling to nodes with taints
    Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
    Example value:
      - key: app
        operator: Equal
        value: infra
        effect: NoSchedule
  EOF
  type        = string
  default     = ""
}

variable "affinity" {
  description = <<EOF
    Affinity and anti-affinity rules for server scheduling to nodes
    Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity
    Example value:
      nodeAffinity:
        preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            preference:
              matchExpressions:
              - key: "app"
                operator: "In"
                values:
                - "infra"
  EOF
  type        = string
  default     = ""
}

variable "custom_helm_values" {
  type        = string
  default     = ""
  description = "Custom YAML helm values"
}

variable "extra_update_status" {
  type        = string
  default     = "false"
  description = "Fix for https://github.com/kubernetes/ingress-nginx/issues/10833"
}

variable "log_format_upstream" {
  type        = string
  default     = <<-EOT
{
  "timestamp": "$time_iso8601",
  "requestID": "$req_id",
  "proxyUpstreamName": "$proxy_upstream_name",
  "proxyAlternativeUpstreamName": "$proxy_alternative_upstream_name",
  "upstreamStatus": "$upstream_status",
  "upstreamAddr": "$upstream_addr",
  "httpRequest": {
    "requestTime": $request_time,
    "requestMethod": "$request_method",
    "requestUrl": "$host$request_uri",
    "status": $status,
    "requestSize": "$request_length",
    "responseSize": "$upstream_response_length",
    "userAgent": "$http_user_agent",
    "remoteIp": "$remote_addr",
    "referer": "$http_referer",
    "x_forward_for": "$proxy_add_x_forwarded_for",
    "x_real_ip": "$http_x_real_ip",
    "latency": "$upstream_response_time s",
    "protocol": "$server_protocol"
  }
}
  EOT
  description = "Log format https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/log-format/"
}

variable "proxy_connect_timeout" {
  type    = number
  default = 60
}

variable "proxy_read_timeout" {
  type    = number
  default = 60
}

variable "proxy_send_timeout" {
  type    = number
  default = 60
}