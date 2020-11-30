provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "moduleEc2" {
  ami = "ami-054362537f5132ce2"
  instance_type = "t2.micro"

  tags {
      Name = var.ec2name
  }
}