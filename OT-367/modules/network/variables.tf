variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}

}

variable "OT367_public_subnet_cidrs" {
  description = "OT-367 public subnet cidr"
  type        = string

}
variable "OT367_private_subnet_cidrs" {
  description = "OT-367 private subnet cidr"
  type        = string
}
variable "OT367_vpc_cidr_block" {
  description = "OT-367 vpc cidr block"
  type        = string

}
