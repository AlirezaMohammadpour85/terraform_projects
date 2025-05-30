variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}

}

variable "OT367_public_subnet_cidrs" {
  description = "OT-367 public subnet cidr"
  type        = list(string)

}

variable "OT367_private_subnet_availability_zone" {
  description = "OT-367 private subnet availability zone"
  type        = string
}

variable "OT367_private_subnet_cidrs" {
  description = "OT-367 private subnet cidr"
  type        = list(string)
}
variable "OT367_vpc_cidr_block" {
  description = "OT-367 vpc cidr block"
  type        = string

}
variable "OT367_ec2_instance_info" {
  description = "OT-367 ec2 instance availability zone"
  type        = object({
    id                = string
    public_ip         = string
    availability_zone = string
  })
}
variable "OT367_elb_sg" {
  description = "OT-367 security group for allowing SSM access"
  type = object({
    id   = string
    name = string
  })
}


variable "acm_certificate_arn" {
  description = "The ARN of the existing ACM certificate"
  type        = string
}

variable "OT367_alb_zone_id" {
  description = "OT-367 alb Zone id"
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
