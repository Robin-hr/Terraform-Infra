# Public Subnet

resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.my-first-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.my-first-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "public-subnet-2"
  }
}


# Internet Gateway

resource "aws_internet_gateway" "my-igw-1" {
  vpc_id = aws_vpc.my-first-vpc.id

  tags = {
    Name = "my-igw-1"
  }
}

# Public Route Table

resource "aws_route_table" "public-rt-1" {
  vpc_id = aws_vpc.my-first-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw-1.id
  }

  tags = {
    Name = "public-rt-1"
  }
}

resource "aws_route_table_association" "public_assoc_1" {
  route_table_id = aws_route_table.public-rt-1.id
  subnet_id      = aws_subnet.public-subnet-1.id

}

resource "aws_route_table_association" "public_assoc_2" {
  route_table_id = aws_route_table.public-rt-1.id
  subnet_id      = aws_subnet.public-subnet-2.id

}
