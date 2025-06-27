terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.5.0"

}

provider "aws" {
  region = "us-east-1"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "terraform-key.pem"
}

resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}

resource "aws_instance" "terraform-master" {
  ami           = "ami-09e6f87a47903347c"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key_pair.key_name

  tags = {
    Name = "terraform-master"
  }

  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }
}
