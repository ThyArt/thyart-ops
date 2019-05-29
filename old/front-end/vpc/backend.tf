terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "front-end/vpc"
    region = "eu-west-1"
  }
}
