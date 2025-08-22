module "sa-external-dns" {
  source            = "git::github.com/alxrem/terraform-yandex-service-account?ref=3.0.0"
  folder_id         = var.folder_id
  name              = "${var.sa_prefix}-externaldns"
  roles             = ["dns.editor"]
  service_account_keys = {
    externaldns = {    
      description       = "dns-operator-cluster"
      key_algorithm     = "RSA_4096"}
  }
}


