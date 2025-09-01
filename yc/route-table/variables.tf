variable "network_id" {
  description = "The ID of the network this route table belongs to"
  type        = string
}

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
  default     = "custom-route-table"
}

variable "static_routes" {
  description = "List of static route configurations"
  type = list(object({
    destination_prefix = string
    next_hop_address   = optional(string)
  }))
  default = []
}
variable "folder_id" {
  description = "Folder ID"
  type        = string
}