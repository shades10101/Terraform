variable "sg_name" {
  type = string
}

variable "in_port"{
  type = string
}

variable "out_port" {
  type = string
}

variable "proto" {
  type = string
}

resource "aws_security_group" "allow" {
  name = "open ports"
  description = "open ports"

  ingress {
    description = "allow port"
    from_port = var.in_port
    to_port = var.out_port
    protocol = var.proto
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = var.in_port
    to_port = var.out_port
    protocol = var.proto
    cidr_blocks = ["0.0.0.0/0"]
  }
}