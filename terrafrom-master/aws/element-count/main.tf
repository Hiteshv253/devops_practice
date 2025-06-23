terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }
}
provider "aws" {

  region = var.aws_region

  access_key = "AKIAXDQWT7U2ISBIMXTY"
  secret_key = "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"
}


resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
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



resource "aws_instance" "first_instance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type

  availability_zone = element(var.az_list, count.index) ## select as AZ base count index | use for geting one by one value from val

  key_name = aws_key_pair.key_pair.key_name

  # Attach the Security Group
  vpc_security_group_ids = [aws_security_group.allow_common.id]

  tags = {
    Name = "ExampleInstance-${count.index}"
  }
  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }
}



## Create Buket of S3

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.bucket_name}-${random_id.suffix.hex}"

  tags = {
    Name = "TerraformStateBucket"
  }

  force_destroy = true
}
