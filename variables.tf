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

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "subnet_cidr_blocks" {
  description = "CIDR Blocks for subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "security_groups" {
  description = "SG configurations"
  type = list(object({
    name         = string
    description  = string
    ingress_port = number
  }))
  default = [{
    name         = "web"
    description  = "Allow web traffic"
    ingress_port = 80
    },
    {
      name         = "app"
      description  = "Allow application traffic"
      ingress_port = 8080
    },
    {
      name         = "db"
      description  = "Allow database traffic"
      ingress_port = 3306
    }
  ]
}