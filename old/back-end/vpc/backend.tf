terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/vpc"
    region = "eu-west-1"
  }
}
