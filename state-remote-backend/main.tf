resource "aws_s3_bucket" "name" {
  bucket = "detyuie90909"
}

resource "aws_instance" "name" {
  ami = "ami-02dfbd4ff395f2a1b"
  instance_type = "t3.micro"
}


