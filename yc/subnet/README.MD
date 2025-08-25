# Yandex Cloud subnet module

This module creates a subnet in Yandex Cloud.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | ~> 0.127 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | ~> 0.127 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_subnet.default](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the folder to create subnet in | `string` | `""` | no |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | The ID of the network to create subnet in | `string` | `""` | no |
| <a name="input_subnet_cidr_blocks"></a> [subnet\_cidr\_blocks](#input\_subnet\_cidr\_blocks) | The CIDR of the subnet to create | `list(string)` | `[]` | no |
| <a name="input_subnet_description"></a> [subnet\_description](#input\_subnet\_description) | The description of the subnet to create | `string` | `""` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet to create | `string` | `""` | no |
| <a name="input_subnet_zone"></a> [subnet\_zone](#input\_subnet\_zone) | The zone of the subnet to create | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_cidr_blocks"></a> [subnet\_cidr\_blocks](#output\_subnet\_cidr\_blocks) | The CIDR blocks of the subnet |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The ID of the subnet |
