resource "github_branch_protection" "protected_branches" {
  count          = "${length(var.protected_branches) * tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  repository     = "${data.github_repository.repository.name}"
  branch         = "${element(var.protected_branches, count.index)}"
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "Travis CI - Branch",
      "Travis CI - Pull Request"
    ]
  }
}