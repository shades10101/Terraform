provider "aws" {
  region = "ca-central-1"
}

resource "aws_instance" "ws" {
  ami = var.ami
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow.name]
}

resource "aws_eip" "ws_eip" {
  instance = aws_instance.ws.id
  vpc = true
}

resource "aws_security_group" "allow" {
  name = "allow HTTPS"
  description = "allow HTTPS"

  ingress {
    description = "allow https"
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
