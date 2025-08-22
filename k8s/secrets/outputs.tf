# modules/kubernetes-secrets/outputs.tf

output "secret_metadata" {
  description = "Metadata of all created secrets"
  value = {
    for secret in kubernetes_secret_v1.secret :
    "${secret.metadata[0].namespace}/${secret.metadata[0].name}" => {
      name       = secret.metadata[0].name
      namespace  = secret.metadata[0].namespace
      uid        = secret.metadata[0].uid
      version    = secret.metadata[0].resource_version
    }
  }
}

output "applied_namespaces" {
  description = "List of namespaces where secrets were created"
  value       = distinct([for s in kubernetes_secret_v1.secret : s.metadata[0].namespace])
}