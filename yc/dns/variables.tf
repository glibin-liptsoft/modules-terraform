variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = null
}

variable "zone_name" {
  default = null
  type = string
  description = "User assigned name of a specific resource. Must be unique within the folder."
}

variable "domain_name" {
  type = string
  description = "The DNS name of this zone, e.g. 'example.com.' Must ends with dot."
}

variable "public" {
  default = true
  type = bool
  description = "The zone's visibility: public zones are exposed to the Internet, while private zones are visible only to Virtual Private Cloud resources."
}

variable "private_networks" {
  default = []
  type = set(string)
  description = "For privately visible zones, the set of Virtual Private Cloud resources that the zone is visible from."
}

variable "records" {
  default = []
  type = list(object({
    name = string
    type = string
    ttl  = number
    records = list(string)
  }))
  description = "DNS records for this domain."
}

variable "records_jsonencoded" {
  description = "List of map of DNS records (stored as jsonencoded string, for terragrunt)"
  type        = string
  default     = null
}