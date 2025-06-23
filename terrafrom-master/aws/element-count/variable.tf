variable "key_name" {
  description = "Name of the SSH key pair"
}

variable "instance_count" {
  description = "NUmber of instance create"
  type        = string
  default     = 2
}

variable "ami" {
  description = "AWS instance AMI"
  type        = string
  default     = "ami-09e6f87a47903347c"
}

variable "instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t2.micro"

}



variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "az_list" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}




variable "bucket_name" {
  description = "S3 bucket name for storing Terraform state"
  type        = string

}






variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}