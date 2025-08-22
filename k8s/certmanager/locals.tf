locals {
  acme_with_eab = {
    for key, value in var.acme :
    key => {
      folder_id = value.folder_id
      server    = value.server
      email     = value.email
      eab       = value.eab
    } if value.eab != null
  }
  acme_without_eab = {
    for key, value in var.acme :
    key => {
      folder_id = value.folder_id
      server    = value.server
      email     = value.email
    } if value.eab == null
  }
}
