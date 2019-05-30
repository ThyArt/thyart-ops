variable "repository_name" {
  type        = "string"
  description = "The GitHub repository name"
}

variable "protected_branches" {
  type        = "list"
  description = "The branches that need to be protected from standard commits"
}