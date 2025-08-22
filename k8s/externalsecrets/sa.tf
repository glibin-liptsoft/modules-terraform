module "sa-external-secret" {
  source            = "git::github.com/alxrem/terraform-yandex-service-account?ref=3.0.0"
  folder_id         = var.folder_id
  name              = "${var.sa_prefix}-externalsecret"
  roles             = ["lockbox.editor","lockbox.payloadViewer","certificate-manager.certificates.downloader"]
  service_account_keys = {
    externalsecret = {    
      description       = "secret-operator-cluster"
      key_algorithm     = "RSA_4096"}
  }
}


