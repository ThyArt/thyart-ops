terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/environment/dev"
    region = "eu-west-1"
  }
}
