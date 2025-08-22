# nginxingress

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.4 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.4.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.8.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.65 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.4.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.custom_errors](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_affinity"></a> [affinity](#input\_affinity) | Affinity and anti-affinity rules for server scheduling to nodes<br>    Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity<br>    Example value:<br>      nodeAffinity:<br>        preferredDuringSchedulingIgnoredDuringExecution:<br>          - weight: 100<br>            preference:<br>              matchExpressions:<br>              - key: "app"<br>                operator: "In"<br>                values:<br>                - "infra" | `string` | `""` | no |
| <a name="input_allowSnippetAnnotations"></a> [allowSnippetAnnotations](#input\_allowSnippetAnnotations) | n/a | `bool` | `false` | no |
| <a name="input_custom_helm_values"></a> [custom\_helm\_values](#input\_custom\_helm\_values) | Custom YAML helm values | `string` | `""` | no |
| <a name="input_default_backend_override"></a> [default\_backend\_override](#input\_default\_backend\_override) | n/a | `bool` | `true` | no |
| <a name="input_enableRealIp"></a> [enableRealIp](#input\_enableRealIp) | n/a | `string` | `"false"` | no |
| <a name="input_enable_nexus_maps"></a> [enable\_nexus\_maps](#input\_enable\_nexus\_maps) | n/a | `bool` | `false` | no |
| <a name="input_extra_update_status"></a> [extra\_update\_status](#input\_extra\_update\_status) | Fix for https://github.com/kubernetes/ingress-nginx/issues/10833 | `string` | `"false"` | no |
| <a name="input_ingressClass"></a> [ingressClass](#input\_ingressClass) | Default ingress class for nginx | `string` | `"nginx"` | no |
| <a name="input_ingressNginxChartVersion"></a> [ingressNginxChartVersion](#input\_ingressNginxChartVersion) | ingress-nginx helm chart version | `string` | `"4.10.1"` | no |
| <a name="input_ingress_controller_kind"></a> [ingress\_controller\_kind](#input\_ingress\_controller\_kind) | n/a | `string` | `"Deployment"` | no |
| <a name="input_ingress_replicas_count"></a> [ingress\_replicas\_count](#input\_ingress\_replicas\_count) | n/a | `number` | `1` | no |
| <a name="input_loadBalancerAnnotations"></a> [loadBalancerAnnotations](#input\_loadBalancerAnnotations) | annotations for creating LoadBalancer with NLB | `map(any)` | `null` | no |
| <a name="input_loadBalancerIP"></a> [loadBalancerIP](#input\_loadBalancerIP) | IP address for creating LoadBalancer with NLB, on k8s | `string` | n/a | yes |
| <a name="input_log_format_upstream"></a> [log\_format\_upstream](#input\_log\_format\_upstream) | Log format https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/log-format/ | `string` | `"{\n  \"timestamp\": \"$time_iso8601\",\n  \"requestID\": \"$req_id\",\n  \"proxyUpstreamName\": \"$proxy_upstream_name\",\n  \"proxyAlternativeUpstreamName\": \"$proxy_alternative_upstream_name\",\n  \"upstreamStatus\": \"$upstream_status\",\n  \"upstreamAddr\": \"$upstream_addr\",\n  \"httpRequest\": {\n    \"requestTime\": $request_time,\n    \"requestMethod\": \"$request_method\",\n    \"requestUrl\": \"$host$request_uri\",\n    \"status\": $status,\n    \"requestSize\": \"$request_length\",\n    \"responseSize\": \"$upstream_response_length\",\n    \"userAgent\": \"$http_user_agent\",\n    \"remoteIp\": \"$remote_addr\",\n    \"referer\": \"$http_referer\",\n    \"x_forward_for\": \"$proxy_add_x_forwarded_for\",\n    \"x_real_ip\": \"$http_x_real_ip\",\n    \"latency\": \"$upstream_response_time s\",\n    \"protocol\": \"$server_protocol\"\n  }\n}\n"` | no |
| <a name="input_metricsServiceConf"></a> [metricsServiceConf](#input\_metricsServiceConf) | k8s service settings for nginx metrics | <pre>object({<br>    type           = string<br>    annotations    = map(any)<br>    loadBalancerIP = string<br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of ingress-nginx | `string` | n/a | yes |
| <a name="input_ns_labels"></a> [ns\_labels](#input\_ns\_labels) | Map with labels for k8s namespace | `map(string)` | <pre>{<br>  "vector.enabled": "true",<br>  "vector.format": "json"<br>}</pre> | no |
| <a name="input_proxyRealIpCidrs"></a> [proxyRealIpCidrs](#input\_proxyRealIpCidrs) | n/a | `string` | `null` | no |
| <a name="input_proxy_connect_timeout"></a> [proxy\_connect\_timeout](#input\_proxy\_connect\_timeout) | n/a | `number` | `60` | no |
| <a name="input_proxy_read_timeout"></a> [proxy\_read\_timeout](#input\_proxy\_read\_timeout) | n/a | `number` | `60` | no |
| <a name="input_proxy_send_timeout"></a> [proxy\_send\_timeout](#input\_proxy\_send\_timeout) | n/a | `number` | `60` | no |
| <a name="input_tolerations"></a> [tolerations](#input\_tolerations) | Node tolerations for server scheduling to nodes with taints<br>    Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/<br>    Example value:<br>      - key: app<br>        operator: Equal<br>        value: infra<br>        effect: NoSchedule | `string` | `""` | no |
| <a name="input_useForwardedHeaders"></a> [useForwardedHeaders](#input\_useForwardedHeaders) | n/a | `string` | `"false"` | no |
| <a name="input_useProxyProtocol"></a> [useProxyProtocol](#input\_useProxyProtocol) | n/a | `string` | `"false"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->