terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "terraform/thyart-ops"
    region = "eu-west-1"
  }
}
