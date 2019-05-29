terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "front-end/application"
    region = "eu-west-1"
  }
}
