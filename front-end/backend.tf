terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key = "front-end"
    region = "eu-west-1"
  }
}