terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }
}

provider "aws" {
  #region     = var.aws_region
  region     = "us-east-1" # change to your region
  access_key = "AKIAXDQWT7U2MGSDEJ6W"
  secret_key = "FdnijyEt+i1AUJ0ojKJjd1+OqeYPyojOVfM4Welc"
}


resource "aws_instance" "web_server" {
  count         = 3                       # deploy 3 instances at once
  ami           = "ami-0c02fb55956c7d316" # Example Amazon Linux 2 in us-east-1
  instance_type = "t2.micro"

  tags = {
    Name        = "web-server-${element(var.environments, count.index)}"
    Environment = element(var.environments, count.index)
  }


  # Attach the Security Group
  vpc_security_group_ids = [aws_security_group.allow_common.id]



  # root_block_device {
  #  volume_size = 20
  #  volume_type = "gp2"
  # }

  lifecycle {
    create_before_destroy = true
  }


  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      var.environments == "dev" ? "sudo yum install -y nginx && sudo systemctl start nginx" : "echo Skipping Nginx",
      var.environments == "prod" ? "sudo yum install -y httpd && sudo systemctl start httpd" : "echo Skipping Apache"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/aws/.ssh/id_rsa")
      host        = self.public_ip
    }
  }


}

provider "local" {}

resource "local_file" "output_ips" {
  content = <<EOT
Public IPs: ${join(", ", aws_instance.web_server[*].public_ip)}
Private IPs: ${join(", ", aws_instance.web_server[*].private_ip)}
EOT

  filename = "${path.module}/instance_ips.txt"
}