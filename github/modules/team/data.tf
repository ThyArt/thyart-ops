data "github_user" "users" {
  count    = "${length(var.team_usernames)}"
  username = "${element(var.team_usernames, count.index)}"
}

data "github_repository" "repository" {
  name = "${var.team_repository}"
}