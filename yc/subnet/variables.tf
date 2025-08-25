variable "network_id" {
  description = "The ID of the network to create subnet in"
  type        = string
  default     = ""
}
variable "folder_id" {
  description = "The ID of the folder to create subnet in"
  type        = string
  default     = ""
}

variable "subnet_cidr_blocks" {
  description = "The CIDR of the subnet to create"
  type        = list(string)
  default     = []
}

variable "subnet_name" {
  description = "The name of the subnet to create"
  type        = string
  default     = ""
}

variable "subnet_zone" {
  description = "The zone of the subnet to create"
  type        = string
  default     = ""
}
variable "subnet_description" {
  description = "The description of the subnet to create"
  type        = string
  default     = ""
}
variable "route_table_id" {
  description = "Route table ID of subnet"
  type        = string
  default     = ""
}