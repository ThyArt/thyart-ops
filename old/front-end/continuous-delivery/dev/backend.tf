terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "front-end/continuous-delivery/dev"
    region = "eu-west-1"
  }
}
