# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr  #You can change the CIDR block as per required
  enable_dns_hostnames = true

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main_vpc_igw"
  }
}

# Public subnet
resource "aws_subnet" "pub_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pub_cidr_1
  availability_zone = var.availability_zone_1
  map_public_ip_on_launch = "true"

  tags = {
    Name = "pub_subnet_1"
  }
}


resource "aws_subnet" "pub_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pub_cidr_2
  availability_zone = var.availability_zone_2
  map_public_ip_on_launch = "true"

  tags = {
    Name = "pub_subnet_2"
  }
}

# Private subnets
resource "aws_subnet" "pvt_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_cidr_1  #You can change the CIDR block as per required
  map_public_ip_on_launch = "false"
  availability_zone = var.availability_zone_1

  tags = {
    Name = "pvt_subnet_1"
  }
}

resource "aws_subnet" "pvt_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = "false"
  availability_zone = var.availability_zone_2
  cidr_block = var.private_cidr_2  #You can change the CIDR block as per required

  tags = {
    Name = "pvt_subnet_2"
  }
}

resource "aws_db_subnet_group" "rds_subnet" {
  name = "rds_subnet"
  subnet_ids = [aws_subnet.pvt_subnet_1.id, aws_subnet.pvt_subnet_2.id]

  tags = {
    Name = "rds_subnet"
  }
}

# Route table
resource "aws_route_table" "pub_rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pub_rtb"
  }
}

resource "aws_eip" "nat_ip" {
  vpc = "true"
}

# Nat GW
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id = aws_subnet.pub_subnet_1.id

  tags = {
    Name = "test_vpc_nat"
  }
}

resource "aws_default_route_table" "pvt_rtb" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "pvt_rtb"
  }
}


resource "aws_route_table_association" "pub_rtb_assoc_1" {
  subnet_id = aws_subnet.pub_subnet_1.id
  route_table_id = aws_route_table.pub_rtb.id
}

resource "aws_route_table_association" "pub_rtb_assoc_2" {
  subnet_id = aws_subnet.pub_subnet_2.id
  route_table_id = aws_route_table.pub_rtb.id
}

resource "aws_network_acl" "pub_nacl" {
  vpc_id = aws_vpc.vpc.id
  subnet_ids = [aws_subnet.pub_subnet_1.id, aws_subnet.pub_subnet_2.id]

  #HTTP Port
  ingress {
    rule_no = 100
    action = "allow"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  #HTTPS Port
  ingress {
    rule_no = 200
    action = "allow"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_block = var.ssh_ip
  }
  #SSH Port
  ingress {
    rule_no = 300
    action = "allow"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  #Ephemeral Ports
  ingress {
    rule_no = 400
    action = "allow"
    from_port = 1024
    to_port = 65535
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }

  #HTTP Port
  egress {
    rule_no = 100
    action = "allow"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  #HTTPS Port
  egress {
    rule_no = 200
    action = "allow"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  #SSH Port
  egress {
    rule_no = 300
    action = "allow"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_block = var.ssh_ip
  }
  #Ephemeral Port
  egress {
    rule_no = 400
    action = "allow"
    from_port = 1024
    to_port = 65535
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "pub_nacl"
  }
}

resource "aws_default_network_acl" "pvt_nacl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id

  ingress {
    rule_no = 100
    action = "allow"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = aws_vpc.vpc.cidr_block
  }

  egress {
    rule_no = 100
    action = "allow"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = aws_vpc.vpc.cidr_block
  }

  tags = {
    Name = "pvt_nacl"
  }
}