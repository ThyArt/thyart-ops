data "github_repository" "repositories" {
  count = length(var.repositories)
  name  = var.repositories[count.index]
}