provider "aws" {
  region = "eu-west-1"
  profile = "Biju"
}
resource "aws_instance" "web-1"{
  ami           = "ami-096800910c1b781ba" # eu-west-1
  instance_type = "t2.micro"
  key_name      = "biju-test"
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  user_data = <<EOF
              #! /bin/bash
              sudo apt-get update
              sudo apt-get install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              EOF
  tags = {
    Name = "web-1"
  }
}
resource "aws_security_group" "web-sg" {
  name        = "allow_web"
  description = "Allow web inbound traffic"

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

output "instance_public_ip" {
  value = aws_instance.web-1.public_ip
  description = "this the piblic ip of the istance"
}