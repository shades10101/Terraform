# Confgiure VPC

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "igw"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Tier = "public"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_c_cidr
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Tier = "public"
  }
}

# Public route tables

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private subnet

resource "aws_subnet" "private_subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.private_subnet_b_cidr
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Tier = "Private"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.private_subnet_c_cidr
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = false

  tags = {
    Tier = "Private"
  }
}

resource "aws_subnet" "db_subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.db_subnet_b_cidr
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Tier = "Private"
  }
}

resource "aws_subnet" "db_subnet_c" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.db_subnet_c_cidr
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = false

  tags = {
    Tier = "Private"
  }
}

# Private route tables

resource "aws_route_table" "private_route_table_b" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_b.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_route_table_b.id
}

resource "aws_route_table" "private_route_table_c" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_c.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_subnet_c.id
  route_table_id = aws_route_table.private_route_table_c.id
}

locals {
  public_nacl_rules = [
    { port : 80, endport : 80, rule_num : 100, cidr : "0.0.0.0/0" },
    { port : 443, endport : 443, rule_num : 110, cidr : "0.0.0.0/0" },
    { port : 1023, endport : 65535, rule_num : 120, cidr : "0.0.0.0/0" }
  ]
}

# Public NACL

resource "aws_network_acl" "public_acl" {
  vpc_id     = aws_vpc.main_vpc.id
  subnet_ids = [aws_subnet.public_subnet_b.id, aws_subnet.public_subnet_c.id]

  dynamic "ingress" {
    for_each = [for rule_obj in local.public_nacl_rules : {
      port       = rule_obj.port
      endport    = rule_obj.endport
      rule_no    = rule_obj.rule_num
      cidr_block = rule_obj.cidr
    }]
    content {
      protocol   = "tcp"
      rule_no    = ingress.value["rule_no"]
      action     = "allow"
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["port"]
      to_port    = ingress.value["endport"]
    }
  }
  tags = {
    Name = "public_acl"
  }
}

locals {
  private_nacl_rules = [
    { port : 80, endport : 80, rule_num : 100, cidr : "0.0.0.0/0" },
    { port : 443, endport : 443, rule_num : 110, cidr : "0.0.0.0/0" },
  ]
}

# Private NACL

resource "aws_network_acl" "private_acl" {
  vpc_id     = aws_vpc.main_vpc.id
  subnet_ids = [aws_subnet.private_subnet_b.id, aws_subnet.private_subnet_c.id, aws_subnet.db_subnet_b.id, aws_subnet.db_subnet_c.id]

  dynamic "ingress" {
    for_each = [for rule_obj in local.private_nacl_rules : {
      port       = rule_obj.port
      endport    = rule_obj.endport
      rule_no    = rule_obj.rule_num
      cidr_block = rule_obj.cidr
    }]
    content {
      protocol   = "tcp"
      rule_no    = ingress.value["rule_no"]
      action     = "allow"
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["endport"]
      to_port    = ingress.value["port"]
    }
  }

  tags = {
    Name = "private_acl"
  }
}

resource "aws_security_group" "public_sg" {
  name        = "allow HTTP/HTTPS"
  description = "allow HTTP/HTTPS"
  vpc_id      = aws_vpc.main_vpc.id

  dynamic "ingress" {
    iterator = port              // can be named anything, just a place holder for the value of the list
    for_each = var.public_irules // Goes through the list as a for loop looking at each value of irules
    content {
      from_port   = port.value //looks at the value of the iterator and assigns it that value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Now it does the same thing for egress rules.
  dynamic "egress" {
    iterator = port
    for_each = var.public_erules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
resource "aws_security_group" "private_sg" {
  name        = "allow certain ports"
  description = "allow certain ports"
  vpc_id      = aws_vpc.main_vpc.id

  dynamic "ingress" {
    iterator = port               // can be named anything, just a place holder for the value of the list
    for_each = var.private_irules // Goes through the list as a for loop looking at each value of irules
    content {
      from_port   = port.value //looks at the value of the iterator and assigns it that value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Now it does the same thing for egress rules.
  dynamic "egress" {
    iterator = port
    for_each = var.private_erules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
# NatGW

resource "aws_eip" "nat_eip_b" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_gw_b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.public_subnet_b.id
  depends_on    = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat_eip_c" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_gw_c" {
  allocation_id = aws_eip.nat_eip_c.id
  subnet_id     = aws_subnet.public_subnet_c.id
  depends_on    = [aws_internet_gateway.igw]
}