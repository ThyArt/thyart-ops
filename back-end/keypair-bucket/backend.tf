terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/keypair-bucket"
    region = "eu-west-1"
  }
}
