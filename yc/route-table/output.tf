output "route_table_id" {
  description = "ID of the created route table"
  value       = yandex_vpc_route_table.route_table.id
}

output "route_table_name" {
  description = "Name of the created route table"
  value       = yandex_vpc_route_table.route_table.name
}