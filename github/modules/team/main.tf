resource "github_team" "team" {
  name = "${var.team_name}"
}

resource "github_team_membership" "team_members" {
  count    = "${length(data.github_user.users)}"
  team_id  = "${github_team.team.id}"
  username = "${element(data.github_user.users, count.index).username}"
}

resource "github_team_repository" "team_repository" {
  repository = "${data.github_repository.repository.name}"
  team_id    = "${github_team.team.id}"
  permission = "admin"
}