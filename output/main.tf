resource "aws_instance" "dev" {
  ami = "ami-02dfbd4ff395f2a1b"
  instance_type = "t3.micro"
}

resource "aws_instance" "uat" {
  ami = "ami-0ec10929233384c7f"
  instance_type = "t3.micro"
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = "kite-909"
  versioning_configuration {
    status = "Enabled"
  }

  
}

resource "aws_security_group" "name" {
  name = "ec2-sg"
}