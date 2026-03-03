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

resource "aws_subnet" "subnet" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "subnet-${count.index + 1}"
  }
}

# Create multiple route tables
resource "aws_route_table" "example_route_table" {
  count = var.route_table_count
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "route-table-${count.index + 1}"
  }
}

# Create multiple security group
resource "aws_security_group" "sg" {
  count       = 3
  name        = "${var.security_groups[count.index].name}-sg"
  description = var.security_groups[count.index].description
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.security_groups[count.index].ingress_port
    to_port     = var.security_groups[count.index].ingress_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.security_groups[count.index].name}-sg"
  }
}