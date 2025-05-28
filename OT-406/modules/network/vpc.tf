########################################################################################################################
## VPC Configuration - Conditional Creation
########################################################################################################################
# This module supports two modes of operation:
# 1. Create a new VPC - when var.existing_vpc_id is empty ("")
# 2. Use an existing VPC - when var.existing_vpc_id contains a valid VPC ID
#
# This dual-mode approach allows the module to be reused across different environments
# and projects without code duplication.
########################################################################################################################

# Create new VPC if existing_vpc_id is empty
# The 'count' parameter controls whether this resource is created:
# - count = 1: Resource is created (when existing_vpc_id is empty)
# - count = 0: Resource is not created (when existing_vpc_id has a value)
resource "aws_vpc" "main" {
  count = var.existing_vpc_id == "" ? 1 : 0
  
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.common_tags["project"]}-vpc"
    }
  )
}

# Fetch details of an existing VPC when existing_vpc_id is provided
# This data source is only activated when we're using an existing VPC
# The 'count' logic is opposite of the resource above - ensuring only one is active
data "aws_vpc" "existing" {
  count = var.existing_vpc_id != "" ? 1 : 0
  id    = var.existing_vpc_id
}

########################################################################################################################
## Local Values - Internal Module Variables
########################################################################################################################
# Local values are used here because:
# 1. We need to compute which VPC ID to use based on the mode of operation
# 2. This computed value needs to be used in multiple places within this module
# 3. Variables cannot be assigned values within a module (they are read-only inputs)
# 4. These values are for internal module use only, not for exposure to parent modules
#
# The conditional (ternary) operator checks:
# - If existing_vpc_id is provided (!= ""): use the data source values
# - If existing_vpc_id is empty (== ""): use the newly created resource values
# 
# The [0] index is required because 'count' creates a list of resources/data sources,
# even when count = 1, Terraform treats it as a list with one element
locals {
  # Determine which VPC ID to use throughout this module
  # This will be referenced as 'local.vpc_id' in other resources within this module
  vpc_id = var.existing_vpc_id != "" ? data.aws_vpc.existing[0].id : aws_vpc.main[0].id
  
  # Determine which CIDR block to use (needed for subnet calculations and outputs)
  # This ensures we always have access to the VPC's CIDR block regardless of mode
  vpc_cidr_block = var.existing_vpc_id != "" ? data.aws_vpc.existing[0].cidr_block : aws_vpc.main[0].cidr_block
}