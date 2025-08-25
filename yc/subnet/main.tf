resource "yandex_vpc_subnet" "default" {
  name           = var.subnet_name
  description    = var.subnet_description
  network_id     = var.network_id
  v4_cidr_blocks = var.subnet_cidr_blocks
  zone           = var.subnet_zone
  folder_id      = var.folder_id
  route_table_id = var.route_table_id
}