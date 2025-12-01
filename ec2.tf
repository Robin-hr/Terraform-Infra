#Private Instances

resource "aws_instance" "private_ec2_1" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private-subnet-1.id
  key_name      = var.key_name
  vpc_security_group_ids =[aws_security_group.ec2_sg.id]

  tags = {
    Name = "private-ec2-1"
  }
}

resource "aws_instance" "private_ec2_2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private-subnet-2.id
  key_name      = var.key_name
  vpc_security_group_ids =[aws_security_group.ec2_sg.id]
  
  tags = {
    Name = "private-ec2-2"
  }
}


#Public Instance

resource "aws_instance" "public_ec2" {
    ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public-subnet-1.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "public-ec2"
  }
}
