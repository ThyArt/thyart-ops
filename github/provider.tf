provider "aws" {
  region = var.aws_region
}

provider "github" {
  token        = var.github_token
  organization = var.github_organization
}