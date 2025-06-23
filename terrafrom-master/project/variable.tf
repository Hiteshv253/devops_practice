variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "environments" {
  description = "List of environments to deploy"
  type        = list(string)
  default     = ["dev", "stage", "prod"]
}
