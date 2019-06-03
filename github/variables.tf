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

/* Back-end */
variable "back_end_repository" {
  type        = "string"
  description = "The GitHub repository associated to the back-end team"
  default     = "thyart-api"
}

variable "back_end_team_name" {
  type        = "string"
  description = "The GitHub team name associated to the back-end team"
  default     = "back-end"
}

variable "back_end_team_usernames" {
  type        = "list"
  description = "The GitHub usernames associated to the back-end team"
  default = [
    "Ajod",
    "CorvinAlex"
  ]
}

/* Membership */
variable "members" {
  type        = "list"
  description = "The GitHub usernames associated to all members of the organization"
  default = [
    "Ajod",
    "CorvinAlex",
    "tisserm",
    "jean-gblr",
    "alambrinidis"
  ]
}

/* Front-end */
variable "front_end_repository" {
  type        = "string"
  description = "The GitHub repository associated to the front-end team"
  default     = "thyart-web"
}

variable "front_end_team_name" {
  type        = "string"
  description = "The GitHub team name associated to the front-end team"
  default     = "front-end"
}

variable "front_end_team_usernames" {
  type        = "list"
  description = "The GitHub usernames associated to the front-end team"
  default = [
    "tisserm",
    "jean-gblr"
  ]
}

/* Ops */
variable "ops_repository" {
  type        = "string"
  description = "The GitHub repository associated to the ops team"
  default     = "thyart-ops"
}

variable "ops_team_name" {
  type        = "string"
  description = "The GitHub team name associated to the ops team"
  default     = "ops"
}

variable "ops_team_usernames" {
  type        = "list"
  description = "The GitHub usernames associated to the ops team"
  default = [
    "DeseineClement",
    "alambrinidis"
  ]
}