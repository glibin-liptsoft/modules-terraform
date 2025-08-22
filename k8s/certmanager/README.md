<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.4.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.8.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.65 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.4.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.8.0 |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.65 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.acme-with-eab](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.acme-without-eab](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.cert-manager-webhook-yandex](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.eab](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [yandex_iam_service_account.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account) | resource |
| [yandex_iam_service_account_key.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account_key) | resource |
| [yandex_resourcemanager_folder_iam_member.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acme"></a> [acme](#input\_acme) | ACME registration configuration | <pre>map(object({<br>    folder_id = string,<br>    server    = string,<br>    email     = string,<br>    eab       = optional(object({<br>      key_id   = string,<br>      hmac_key = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_cert_manager_webhook_yandex_chart_values"></a> [cert\_manager\_webhook\_yandex\_chart\_values](#input\_cert\_manager\_webhook\_yandex\_chart\_values) | cert-manager-webhook-yandex helm chart values | `string` | `"    cert-manager:\n      installCRDs: false\n"` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the ServiceAccount in yc | `string` | `null` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Target to folder, to create DNS-records for cert-manager | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of cert-manager, used for ServiceAccount name, namespace, helm, etc | `string` | n/a | yes |
| <a name="input_sa_prefix"></a> [sa\_prefix](#input\_sa\_prefix) | Prefix for ServiceAccount | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->