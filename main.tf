# Get information about the current region
data "aws_region" "current" {}

locals {
  # Common tags for all resources
  common_tags = {
    Environment = var.environment
    Project     = "terraform-demo"
    Owner       = "infrastructure-team"
    CostCenter  = "cc-1234"
    Region      = data.aws_region.current.name
    ManagedBy   = "terraform"
  }

  # Common name prefix for resources
  name_prefix = "${var.environment}-"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${local.name_prefix}vpc-${data.aws_region.current.name}"
    Environment = local.common_tags.Environment
    Project     = local.common_tags.Project
    Owner       = local.common_tags.Owner
    CostCenter  = local.common_tags.CostCenter
    Region      = local.common_tags.Region
    ManagedBy   = local.common_tags.ManagedBy
  }
}

/*
# Subnets created using "count" instead of for_each
resource "aws_subnet" "subnet" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "subnet-${count.index + 1}"
  }
}
*/

# Create multiple subnets using for_each
resource "aws_subnet" "subnet_foreach" {
  for_each          = var.subnet_config
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.subnet_azs[each.key]

  tags = {
    Name = "subnet-${each.key}"
    Tier = "standard"
  }
}


# Create multiple route tables
resource "aws_route_table" "rt" {
  for_each = var.route_tables
  vpc_id   = aws_vpc.main.id

  tags = {
    Name        = "route-table-${each.key}"
    Description = each.value
  }
}

# Create security group with for_each
resource "aws_security_group" "sg_foreach" {
  for_each    = var.security_group_config
  name        = "${each.key}-sg-foreach"
  description = "Security group for ${each.key} servers"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${each.key}-sg-foreach"
  }
}

resource "aws_security_group_rule" "ingress_foreach" {
  for_each          = var.security_group_config
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_foreach[each.key].id
}

resource "aws_iam_user" "iam" {
  for_each = var.iam_users
  name     = each.key
}