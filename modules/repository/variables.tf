variable "repository_name" {
  type        = "string"
  description = "The GitHub repository name"
}

variable "protected_branches" {
  type        = "list"
  description = "The branches that need to be protected from standard commits"
}

variable "should_be_created" {
  type        = "string"
  description = "True if value should be created, false otherwise"
}