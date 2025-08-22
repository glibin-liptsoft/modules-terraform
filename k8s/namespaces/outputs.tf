output "namespaces" {
  description = "Map of created namespaces"
  value       = kubernetes_namespace.namespace
}

output "namespace_names" {
  description = "List of created namespace names"
  value       = [for ns in kubernetes_namespace.namespace : ns.metadata[0].name]
}

output "resource_quotas" {
  description = "Map of created resource quotas"
  value       = kubernetes_resource_quota.quota
}

output "limit_ranges" {
  description = "Map of created limit ranges"
  value       = kubernetes_limit_range.limit_range
}