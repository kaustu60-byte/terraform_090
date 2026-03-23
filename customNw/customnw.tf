# creating vpc 

resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
      name ="dev-vpc"
    }
}

#creating IG

resource "aws_internet_gateway" "dev" {
    vpc_id = aws_vpc.dev.id
    tags = {
        name="dev-IG"
    }
  
}

#creating public_subnet

resource "aws_subnet" "dev-public-subnet" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.0.0/24"
    tags = {
        name ="public-dev-subnet"
    }
  
}

resource "aws_subnet" "dev-private-subnet" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.1.0/24"
    tags = {
        name="private-dev-subnet"
    }
  
}

#creating route-table and edit routes

resource "aws_route_table" "dev" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev.id
  }
  tags = {
    name="public-subnet-rt"
  }
}

#creating subnet-association
resource "aws_route_table_association" "dev" {
    route_table_id = aws_route_table.dev.id
    subnet_id = aws_subnet.dev-public-subnet.id
  
}

# creating security group.

resource "aws_security_group" "dev" {
    name = "custom-sg"
    description = "allow ingress traffic"
    vpc_id = aws_vpc.dev.id
   
}

resource "aws_vpc_security_group_ingress_rule" "dev" {
  security_group_id = aws_security_group.dev.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "dev" {
  security_group_id = aws_security_group.dev.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "nat-dev" {
  subnet_id     = aws_subnet.dev-public-subnet.id
  allocation_id = aws_eip.nat_eip.id

  tags = {
    Name = "gw NAT"
  }
}

# Route Table for Private Subnet
resource "aws_route_table" "nat-dev" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-dev.id
  }
}

# Associate Route Table with Private Subnet
resource "aws_route_table_association" "dev-private" {
  route_table_id = aws_route_table.nat-dev.id
  subnet_id      = aws_subnet.dev-private-subnet.id
}