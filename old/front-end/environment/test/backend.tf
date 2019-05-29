terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "front-end/environment/test"
    region = "eu-west-1"
  }
}
