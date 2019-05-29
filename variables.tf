/* acknoledgement */
variable "should_create_organization" {
  type        = "string"
  description = "True if organization should be created, false otherwise"
  default     = true
}

variable "should_create_back_end_application" {
  type        = "string"
  description = "True if back-end application should be created, false otherwise"
  default     = true
}

variable "should_create_front_end_application" {
  type        = "string"
  description = "True if front-end application should be created, false otherwise"
  default     = true
}

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

variable "aws_availability_zones" {
  type        = "list"
  description = "The AWS Availability zones used for the creation of subnets"
  default = [
    "eu-west-1a",
    "eu-west-1b",
    "eu-west-1c"
  ]
}

/* Membership */
variable "members" {
  type        = "list"
  description = "The GitHub usernames associated to all members of the organization"
  default = [
    "Ajod",
    "tisserm",
    "jean-gblr"
  ]
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
    "Ajod"
  ]
}

variable "back_end_application_name" {
  type        = "string"
  description = "The AWS elasticbeansalk application name for the back-end"
  default     = "thyart-api"
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

variable "front_end_application_name" {
  type        = "string"
  description = "The AWS elasticbeansalk application name for the front-end"
  default     = "thyart-web"
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
    "DeseineClement"
  ]
}