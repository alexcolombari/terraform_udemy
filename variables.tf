variable "region" {
  description = "Define AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "environment" {
  description = "Define the environment name"
  type        = string
  default     = "development"
}

variable "vpc_cidr" {
  description = "CIDR Block for the main VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
  default     = 3
}

variable "subnet_config" {
  description = "Map of subnet configuration"
  type        = map(string)
  default = {
    "public"   = "10.0.10.0/24"
    "private1" = "10.0.20.0/24"
  }
}

variable "subnet_azs" {
  description = "Map of subnet Availability Zones"
  type        = map(string)
  default = {
    "public"   = "eu-central-1a"
    "private1" = "eu-central-1b"
  }
}

variable "security_group_config" {
  description = "Map of Security Group configuration"
  type        = map(string)
  default = {
    "web"   = 80
    "app"   = 8080
    "db"    = 3306
    "cache" = 6379
  }
}

variable "route_tables" {
  description = "Map of route tables configuration"
  type        = map(string)
  default = {
    "public"   = "Public route table"
    "private1" = "Private route table 1"
    "private2" = "Private route table 2"
  }
}

variable "iam_users" {
  description = "Map of users configuration"
  type        = map(string)
  default = {
    "user1" = "Public route table"
    "user2" = "Private route table 1"
    "user3" = "Private route table 2"
  }
}