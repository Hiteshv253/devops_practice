terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # change to your region
  access_key = "AKIAXDQWT7U2OVHBQEOY"
  secret_key = "0sWyAakmMlnL66/G3UGdimJH7uqmWmM/RGpcOvgN"
}


// To Generate Private Key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

variable "key_name" {
  description = "Name of the SSH key pair"
}

// Create Key Pair for Connecting EC2 via SSH
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

// Save PEM file locally
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}


resource "aws_instance" "terrafrom-master" {
  ami                    = "ami-09e6f87a47903347c"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key_pair.key_name

  tags = {
    Name = "terrafrom-master"
  }

  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }
}