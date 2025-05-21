variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable "ebs_volume_size" {
  description = "EBS volume size in GB"
  type        = number
  
  validation {
    condition     = floor(var.ebs_volume_size) == var.ebs_volume_size
    error_message = "The ebs_volume_size must be an integer (whole number)."
  }
  
  validation {
    condition     = var.ebs_volume_size >= 1
    error_message = "EBS GP3 volumes must be at least 1 GB in size."
  }
}

variable "OT367_ec2_instance_info" {
  description = "OT-367 ec2 instance availability zone"
  type        = object({
    id                = string
    public_ip         = string
    availability_zone = string
  })
}

