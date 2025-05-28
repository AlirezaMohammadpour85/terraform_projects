variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
variable "OT367_vpc_id" {
  description = "OT-367 vpc id"
  type        = string
}


# Variables for existing peer connections
variable "existing_peering_connection_ids" {
  description = "IDs of existing VPC peering connections"
  type        = list(string)
  default     = []
}

variable "peer_vpc_cidr_blocks" {
  description = "CIDR blocks of the peer VPCs"
  type        = list(string)
  default     = []
}