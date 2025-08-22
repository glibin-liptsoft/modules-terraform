resource "random_string" "unique_id" {
  count = "${var.single_bucket == true ? 1 : 0}"
  length  = 10
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "yandex_storage_bucket" "default" {
  count = "${var.single_bucket == true ? 1 : 0}"
  access_key = yandex_iam_service_account_static_access_key.default.access_key
  secret_key = yandex_iam_service_account_static_access_key.default.secret_key
  bucket     = "${var.name}-${random_string.unique_id[0].result}"
  max_size   = var.max_size

  depends_on = [ 
    yandex_iam_service_account.default,
    yandex_resourcemanager_folder_iam_member.default,
    yandex_iam_service_account_static_access_key.default
   ]
}
