terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/continuous-delivery/dev"
    region = "eu-west-1"
  }
}
