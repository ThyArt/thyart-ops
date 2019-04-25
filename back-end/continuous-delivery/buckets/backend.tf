terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/continuous-delivery/buckets"
    region = "eu-west-1"
  }
}
