# Private Subnet

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.my-first-vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet-1"
  }
}

# Private Subnet

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.my-first-vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-2"
  }
}

#EIP


    resource "aws_eip" "nat_gateway_eip" {
      domain = "vpc"
      tags = {
        Name = "nat-gateway-eip"
      }
    }



# NAT Gateway 

resource "aws_nat_gateway" "NTGW-1" {
  allocation_id     = aws_eip.nat_gateway_eip.id
  subnet_id         = aws_subnet.public-subnet-1.id

  tags = {
    Name = "NTGW-1"
  }
}

# Private Route Table

resource "aws_route_table" "private-rt-1" {
  vpc_id = aws_vpc.my-first-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NTGW-1.id
  }

  tags = {
    Name = "private-rt-1"
  }
}

resource "aws_route_table_association" "private_assoc_1" {
  route_table_id = aws_route_table.private-rt-1.id
  subnet_id      = aws_subnet.private-subnet-1.id

}

resource "aws_route_table_association" "private_assoc_2" {
  route_table_id = aws_route_table.private-rt-1.id
  subnet_id      = aws_subnet.private-subnet-2.id

}
