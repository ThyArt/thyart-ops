resource "github_team" "team" {
  count = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  name  = "${var.team_name}"
}

resource "github_team_membership" "team_members" {
  count    = "${length(data.github_user.users) * tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  team_id  = "${github_team.team.0.id}"
  username = "${element(data.github_user.users, count.index).username}"
}

resource "github_team_repository" "team_repository" {
  count      = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  repository = "${data.github_repository.repository.name}"
  team_id    = "${github_team.team.0.id}"
  permission = "admin"
}