variable "ec2name" {
  type = string
}

resource "aws_instance" "amazon_linux_ec2" {
  ami = "ami-054362537f5132ce2"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow.name]
  
  tags = {
    Name = var.ec2name
  }
}
