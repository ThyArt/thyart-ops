terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "front-end/environment/dev"
    region = "eu-west-1"
  }
}
