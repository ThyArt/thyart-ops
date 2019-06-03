/* GitHub resources */
resource "github_membership" "members" {
  count    = length(data.github_user.users)
  username = data.github_user.users[count.index].username
}

module "team_back_end" {
  source          = "./modules/team"
  team_usernames  = var.back_end_team_usernames
  team_name       = var.back_end_team_name
  team_repository = var.back_end_repository
}

module "team_front_end" {
  source          = "./modules/team"
  team_usernames  = var.front_end_team_usernames
  team_name       = var.front_end_team_name
  team_repository = var.front_end_repository
}

module "team_ops" {
  source          = "./modules/team"
  team_usernames  = var.ops_team_usernames
  team_name       = var.ops_team_name
  team_repository = var.ops_repository
}

module "repository_back_end" {
  source             = "./modules/repository"
  repository_name    = var.back_end_repository
  protected_branches = ["master", "dev"]
}

module "repository_front_end" {
  source             = "./modules/repository"
  repository_name    = var.front_end_repository
  protected_branches = ["master", "dev"]
}

module "repository_ops" {
  source             = "./modules/repository"
  repository_name    = var.ops_repository
  protected_branches = ["master"]
}