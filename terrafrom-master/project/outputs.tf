output "instance_public_ips" {
  description = "Public IPs of all EC2 instances"
  value       = aws_instance.web_server[*].public_ip
}

output "instance_private_ips" {
  description = "Private IPs of all EC2 instances"
  value       = aws_instance.web_server[*].private_ip
}





output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.allow_common.id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = aws_security_group.allow_common.name
}

output "security_group_arn" {
  description = "The ARN of the security group"
  value       = aws_security_group.allow_common.arn
}
