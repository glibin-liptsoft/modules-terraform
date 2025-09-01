# Yandex Cloud Route Table Module

This Terraform module creates a Yandex Cloud route table with configurable static routes.

## Usage

```hcl
module "lab_rt_a" {
  source = "./modules/yandex_route_table"

  network_id      = yandex_vpc_network.lab-net.id
  route_table_name = "lab-rt-a"

  static_routes = [
    {
      destination_prefix = "10.2.0.0/16"
      next_hop_address   = "172.16.10.10"
    },
    {
      destination_prefix = "0.0.0.0/0"
      gateway_id         = yandex_vpc_gateway.egress-gateway.id
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| network_id | The ID of the network this route table belongs to | `string` | n/a | yes |
| route_table_name | Name of the route table | `string` | `"custom-route-table"` | no |
| static_routes | List of static route configurations | `list(object({...}))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| route_table_id | ID of the created route table |
| route_table_name | Name of the created route table |