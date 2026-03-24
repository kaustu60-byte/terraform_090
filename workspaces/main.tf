provider "aws" {
    region = "ap-southeast-2"
  
}

resource "aws_instance" "name" {
  ami = "ami-0446b78c6bc15b220"
  instance_type = "t3.micro"
}