terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/environment/test"
    region = "eu-west-1"
  }
}
