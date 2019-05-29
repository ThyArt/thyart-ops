terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/environment/prod"
    region = "eu-west-1"
  }
}
