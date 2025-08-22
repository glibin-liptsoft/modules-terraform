output "namespace" {
  value = "${var.name}"
}

output "secret_auth" {
  value = "sa-creds"
}

output "secret_auth_key" {
  value = "key"
}

output "ClusterSecretStore_yandexlockbox" {
  value = var.cluster_secret_store_yandexlockbox ? "secret-store-yandexlockbox" : ""
}

output "ClusterSecretStore_yandexcertificatemanager" {
  value = var.cluster_secret_store_yandexcertificate ? "secret-store-yandexcertificatemanager" : ""
}