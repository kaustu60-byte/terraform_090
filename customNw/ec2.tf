#creation off server

resource "aws_instance" "dev" {
    ami = "ami-0446b78c6bc15b220"
    instance_type = "t3.micro"
    key_name = "sydney-key"
    subnet_id = aws_subnet.dev-public-subnet.id
    vpc_security_group_ids = [aws_security_group.dev.id]
    tags = {
        name ="public-ec2"
    }
  
}