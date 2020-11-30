variable "vpcname" {
    default = "UE1-BF"
}


String example - Used for Strings and whole numbers

variable “region” {
  Default = “us-east-2”
}

List example - Array

variable list-example {

  type = list(string)

  default = [
    "value1",
    "value2",
  ]
}
  

provider "aws" {
    region = "us-east-1"
}

variable "vpcname" {
    default = "UE1-BF"
}

resource "aws_vpc" "main" {
    cidr_block = "192.168.0.0/24"

    tags {
        Name = var.vpc_name
    }
}

output "vpcid"
  value = aws_vpc.main.id