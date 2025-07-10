output "instance_public_ips" {
  description = "Public IPs of all EC2 instances"
  value       = aws_instance.first_instance[*].public_ip
}

output "instance_private_ips" {
  description = "Private IPs of all EC2 instances"
  value       = aws_instance.first_instance[*].private_ip
}


# S3 Value print into CLI
output "s3_bucket_name" {
  description = "The name of the S3 bucket used for Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.terraform_state.arn
}

output "s3_bucket_region" {
  description = "The region of the S3 bucket"
  value       = var.aws_region
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