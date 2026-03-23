terraform {
  backend "s3" {
    bucket = "kite-909"
    key    = "output.tfstate"
    region = "us-east-1"
    use_lockfile ="true"
    encrypt = true
    
  }
}
