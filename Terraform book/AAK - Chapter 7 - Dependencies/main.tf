provider "aws" {
  region = "ca-central-1"
}

resource "aws_instance" "ws" {
  // Count will create 2 servers
  count = 2
  ami = var.ami
  instance_type = "t2.micro"
  tags = {
    Name = "WS ${count.index}" // ${} is used because Terraform sees "" and would normally take that as a string
  }                            // But ${} tells Terraform to execute the code.

// This is how you set a manual dependency on the resource below
  depends_on = [aws_instance.db]
}

resource "aws_instance" "db" {
  ami = var.ami
  instance_type = "t2.micro"
  tags = {
    Name = "db"
  }
}