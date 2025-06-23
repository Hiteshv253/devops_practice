terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1" # change to your region
  access_key = "AKIAXDQWT7U2MGSDEJ6W"
  secret_key = "FdnijyEt+i1AUJ0ojKJjd1+OqeYPyojOVfM4Welc"
}

resource "aws_instance" "my_instance" {

  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
}

##terraform import aws_instance.my_instance i-0caabdc4ac40e38c7
##terraform plan