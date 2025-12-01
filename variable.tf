variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "aws_keypair_robin"
}

variable "ami" {
  type = string
  default = "ami-0fa3fe0fa7920f68e"
}

