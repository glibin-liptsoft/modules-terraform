resource "yandex_vpc_route_table" "route_table" {
  network_id = var.network_id
  folder_id  = var.folder_id
  name       = var.route_table_name

  dynamic "static_route" {
    for_each = var.static_routes
    content {
      destination_prefix = static_route.value.destination_prefix
      next_hop_address   = lookup(static_route.value, "next_hop_address", null)
    }
  }
}