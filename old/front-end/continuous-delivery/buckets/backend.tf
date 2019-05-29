terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "front-end/continuous-delivery/buckets"
    region = "eu-west-1"
  }
}
