variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable "ebs_volume_size" {
  description = "EBS volume size"
  
}


variable "OT367_ec2_instance_info" {
  description = "OT-367 ec2 instance availability zone"
  type        = object({
    id                = string
    public_ip         = string
    availability_zone = string
  })
}

