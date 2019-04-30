terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "front-end/environment/prod"
    region = "eu-west-1"
  }
}
