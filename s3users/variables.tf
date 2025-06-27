variable "aws_region" {
  description = "AWS region to use"
  type        = string
  default     = "us-east-1"
}

variable "bucket_prefix" {
  description = "Prefix for bucket names and IAM users"
  type        = string
  default     = "envapp"
}
