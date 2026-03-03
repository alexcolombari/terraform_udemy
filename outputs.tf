output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the Subnet"
  value       = aws_subnet.subnet[*].id
}

output "security_group_id" {
  description = "ID of the Security Group"
  value       = aws_security_group.web.id
}