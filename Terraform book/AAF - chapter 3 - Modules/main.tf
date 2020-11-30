provider "aws" {
  region = "us-east-1"
}
resource "aws_iam_user" "mainUser" {
    name = "MainUser"
}

module "ec2module" {
  source = "./modules/ec2"
  ec2name = "Mailserver1"
}