terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key = "back-end/application"
    region = "eu-west-1"
  }
}