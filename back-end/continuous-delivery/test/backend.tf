terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/continuous-delivery/test"
    region = "eu-west-1"
  }
}
