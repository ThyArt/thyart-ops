data "github_user" "users" {
  count    = length(var.members)
  username = var.members[count.index]
}