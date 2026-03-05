output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "subnets_id" {
  description = "Subnets IDs"
  value       = aws_subnet.subnet_foreach
}

output "security_group_id" {
  description = "SG IDs"
  value       = aws_security_group.sg_foreach
}

output "route_tables_id" {
  description = "Route Tables ID"
  value       = aws_route_table.rt
}