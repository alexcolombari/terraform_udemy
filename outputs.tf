output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_a_id" {
  description = "ID of the Subnet Public A"
  value       = aws_subnet.public_a.id
}

output "public_subnet_b_id" {
  description = "ID of the Subnet Public B"
  value       = aws_subnet.public_b.id
}

output "private_subnet_a_id" {
  description = "ID of the Subnet Private A"
  value       = aws_subnet.private_a.id
}

output "private_subnet_b_id" {
  description = "ID of the Subnet Private B"
  value       = aws_subnet.private_b.id
}

output "security_group_id" {
  description = "ID of the Security Group"
  value       = aws_security_group.web.id
}