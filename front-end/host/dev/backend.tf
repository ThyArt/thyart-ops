terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "front-end/host/dev"
    region = "eu-west-1"
  }
}
