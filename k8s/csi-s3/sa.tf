resource "yandex_iam_service_account" "default" {
  name        = "${var.sa_prefix}-${var.name}"
  description = "sa for csi-s3 operator in k8s"
  folder_id   = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "default" {
  folder_id = var.folder_id
  member    = "serviceAccount:${yandex_iam_service_account.default.id}"
  role      = "storage.editor"
}

resource "yandex_iam_service_account_static_access_key" "default" {
  service_account_id = yandex_iam_service_account.default.id
  description = "key for csi-s3 operator"
}
