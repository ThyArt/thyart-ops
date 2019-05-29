terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "front-end/continuous-delivery/test-prod"
    region = "eu-west-1"
  }
}
