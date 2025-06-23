variable "key_name" {
  description = "The name of your existing AWS EC2 Key Pair (without .pem)"
  type        = string
}

variable "pem_file_path" {
  description = "Local path to your downloaded .pem file"
  type        = string
}

resource "aws_instance" "example" {
  ami           = "ami-0c02fb55956c7d316"  # Change to valid AMI ID for your region
  instance_type = "t2.micro"

  # ✅ This must match the Key Pair name in AWS Console exactly
  key_name = var.key_name

  # ✅ Connection config tells Terraform how to SSH
  connection {
    type        = "ssh"
    user        = "ec2-user"    # Amazon Linux default
    private_key = file(var.pem_file_path)
    host        = self.public_ip
  }

  # ✅ Example provisioner
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }

  tags = {
    Name = "ExampleInstance"
  }
}
