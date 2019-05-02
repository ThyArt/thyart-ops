terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/frontend-configuration"
    region = "eu-west-1"
  }
}
