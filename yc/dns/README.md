### Yandex.Cloud Terraform DNS module
Original: https://github.com/darzanebor/terraform-yandex-dns
#### Example
```
locals {
  zones = {
    "example.com" = {
        name = "example-com-zone-name",
        public = true,
        records = [
          { name = "www",             type = "CNAME",ttl   = 3600,  records = ["example.com."] },
          { name = "*.dev",           type = "CNAME",ttl   = 3600,  records = ["example.com."] },
          { name = "*.prod",          type = "CNAME",ttl   = 3600,  records = ["example.com."] },
          { name = "",                type = "A",    ttl   = 3600,  records = ["1.0.0.1",] },
          { name = "",                type = "MX",   ttl   = 3600,  records = ["10 mx.example.com.",] },
          { name = "",                type = "TXT",  ttl   = 3600,  records = ["v=spf1 redirect=_spf.example.com"] },
        ]
    },
    "example.net" = {
        name = "example-net-zone-name",
        public = true,
        records = [
          { name = "www",             type = "CNAME",ttl   = 3600,  records = ["example.net."] },
          { name = "*.dev",           type = "CNAME",ttl   = 3600,  records = ["example.net."] },
          { name = "*.prod",          type = "CNAME",ttl   = 3600,  records = ["example.net."] },
          { name = "",                type = "A",    ttl   = 3600,  records = ["1.0.0.1",] },
          { name = "",                type = "MX",   ttl   = 3600,  records = ["10 mx.example.net.",] },
          { name = "",                type = "TXT",  ttl   = 3600,  records = ["v=spf1 redirect=_spf.example.net"] },
        ]
    }
  }
}
```
```
module "dns_zone" {
  source           = "github.com/darzanebor/terraform-yandex-dns.git"
  for_each         = local.zones
  domain_name      = each.key
  records          = lookup(each.value, "records")
  public           = lookup(each.value, "public")
  zone_name        = lookup(each.value, "name")
  private_networks = lookup(each.value, "private_networks", null)
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.13 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_dns_recordset.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_recordset) | resource |
| [yandex_dns_zone.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The DNS name of this zone, e.g. 'example.com.' Must ends with dot. | `any` | n/a | yes |
| <a name="input_private_networks"></a> [private\_networks](#input\_private\_networks) | For privately visible zones, the set of Virtual Private Cloud resources that the zone is visible from. | `list` | `[]` | no |
| <a name="input_public"></a> [public](#input\_public) | The zone's visibility: public zones are exposed to the Internet, while private zones are visible only to Virtual Private Cloud resources. | `bool` | `true` | no |
| <a name="input_records"></a> [records](#input\_records) | DNS records for this domain. | `list` | `[]` | no |
| <a name="input_records_jsonencoded"></a> [records\_jsonencoded](#input\_records\_jsonencoded) | List of map of DNS records (stored as jsonencoded string, for terragrunt) | `string` | `null` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | User assigned name of a specific resource. Must be unique within the folder. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_yandex_dns_recordset"></a> [yandex\_dns\_recordset](#output\_yandex\_dns\_recordset) | recordset output |
| <a name="output_yandex_dns_zone"></a> [yandex\_dns\_zone](#output\_yandex\_dns\_zone) | dns_zone output |
