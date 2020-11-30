resource "aws_vpc" "main" {
    cidr_block = "192.168.0.0/24"

    tags {
        Name = var.vpc_name
    }
}

output "vpcid"
  value = aws_vpc.main.id