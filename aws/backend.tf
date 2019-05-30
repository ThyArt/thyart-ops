terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "aws"
    region = "eu-west-1"
  }
}
