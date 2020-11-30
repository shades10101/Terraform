provider "aws" {
  region = "ca-central-1"
}

resource "aws_instance" "db" {
  // This will fail cause t2.micro for that AMI is not supported (SQL server)
  ami = var.ami
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow.name]
}

resource "aws_instance" "ws" {
  ami = var.ami
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow.name]
  // Theres also the method of using: 
  //user_data = [{$file{original.sh}}]
  provisioner "file" {
    source = "original.sh"
    destination = "/tmp/original.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod =x /tmp/original.sh",
      "/tmp/original.sh args",
    ]
  }
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
  ingress {
    from_port = 80
    to_port = 80
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
