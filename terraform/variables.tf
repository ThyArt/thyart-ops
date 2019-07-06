/* Providers */
variable "github_token" {
  type        = "string"
  description = "The GitHub personnal access token"
}

variable "github_organization" {
  type        = "string"
  description = "The GitHub organization name"
  default     = "ThyArt"
}

variable "aws_region" {
  type        = "string"
  description = "The default AWS region used for deployment"
  default     = "eu-west-1"
}

variable "repositories" {
  type        = list(string)
  description = "The GitHub repositories used for the project"
  default = [
    "thyart-web",
    "thyart-api",
  ]
}

variable "scaleway_organization" {
  type        = "string"
  description = "The Scaleway organization token"
}

variable "scaleway_token" {
  type        = "string"
  description = "The Scaleway access token"
}

variable "scaleway_region" {
  type        = "string"
  description = "The default Scaleway region used for deployment"
  default     = "par1"
}