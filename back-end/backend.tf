terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key = "back-end"
    region = "eu-west-1"
  }
}