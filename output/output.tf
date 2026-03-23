output "ami" {
    value = aws_instance.dev.ami
  
}
output "ip" {
    value = aws_instance.uat.public_ip
  
}

output "private_ip" {
    value = aws_instance.uat.private_ip
    sensitive = true
  
}