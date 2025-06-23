terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }
}


resource "aws_instance" "nginx_server" {
  ami = "ami-09e6f87a47903347c"

  instance_type = "t2.micro"
  key_name      = var.key_name

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx git",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo git clone https://github.com/Hiteshv253/zenerativeminds.com.git /usr/share/nginx/html"
    ]
  }
}
