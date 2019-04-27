terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "monitoring/agent"
    region = "eu-west-1"
  }
}
