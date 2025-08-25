output "subnet_id" {
  value = yandex_vpc_subnet.default.id
  description = "The ID of the subnet"
}
output "subnet_cidr_blocks" {
  value = yandex_vpc_subnet.default.v4_cidr_blocks
  description = "The CIDR blocks of the subnet"
}
output "subnet_zone" {
  value = yandex_vpc_subnet.default.zone
  description = "The availability zone of the subnet"
}