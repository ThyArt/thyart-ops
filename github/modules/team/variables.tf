variable "team_name" {
  type        = "string"
  description = "The GitHub team name"
}

variable "team_repository" {
  type        = "string"
  description = "The GitHub repository related to the team"
}

variable "team_usernames" {
  type        = "list"
  description = "The GitHub username of the team members."
}