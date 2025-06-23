resource "aws_instance" "nginx_server" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (region-specific)
  instance_type = "t2.micro"
  key_name      = var.key_name  # This must match the Key Pair name in AWS exactly

  connection {
    type        = "ssh"
    user        = "ec2-user" # Amazon Linux default user
    private_key = file(var.pem_file_path)
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

  tags = {
    Name = "nginx-server"
  }
}
