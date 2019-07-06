provider "aws" {
  region = var.aws_region
}

provider "github" {
  token        = var.github_token
  organization = var.github_organization
}

provider "scaleway" {
  organization = var.scaleway_organization
  token        = var.scaleway_token
  region       = var.scaleway_region
}