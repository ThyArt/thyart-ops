data "github_user" "users" {
  count    = "${length(var.members)}"
  username = "${element(var.members, count.index)}"
}