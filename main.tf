/* GitHub resources */
resource "github_membership" "members" {
  count    = "${length(data.github_user.users) * tonumber(replace(replace(var.should_create_organization, false, 0), true, 1))}"
  username = "${element(data.github_user.users, count.index).username}"
}

module "team_back_end" {
  source            = "./modules/team"
  team_usernames    = "${var.back_end_team_usernames}"
  team_name         = "${var.back_end_team_name}"
  team_repository   = "${var.back_end_repository}"
  should_be_created = "${var.should_create_organization}"
}

module "team_front_end" {
  source            = "./modules/team"
  team_usernames    = "${var.front_end_team_usernames}"
  team_name         = "${var.front_end_team_name}"
  team_repository   = "${var.front_end_repository}"
  should_be_created = "${var.should_create_organization}"
}

module "team_ops" {
  source            = "./modules/team"
  team_usernames    = "${var.ops_team_usernames}"
  team_name         = "${var.ops_team_name}"
  team_repository   = "${var.ops_repository}"
  should_be_created = "${var.should_create_organization}"
}

module "repository_back_end" {
  source             = "./modules/repository"
  repository_name    = "${var.back_end_repository}"
  protected_branches = ["master", "dev"]
  should_be_created  = "${var.should_create_organization}"
}

module "repository_front_end" {
  source             = "./modules/repository"
  repository_name    = "${var.front_end_repository}"
  protected_branches = ["master", "dev"]
  should_be_created  = "${var.should_create_organization}"
}

module "repository_ops" {
  source             = "./modules/repository"
  repository_name    = "${var.ops_repository}"
  protected_branches = ["master"]
  should_be_created  = "${var.should_create_organization}"
}

/* AWS resources */
module "application_backend" {
  source                 = "./modules/application"
  application_name       = "${var.back_end_application_name}"
  aws_availability_zones = "${var.aws_availability_zones}"
  aws_region             = "${var.aws_region}"
  should_be_created      = "${var.should_create_back_end_application}"
}

module "application_frontend" {
  source                 = "./modules/application"
  application_name       = "${var.front_end_application_name}"
  aws_availability_zones = "${var.aws_availability_zones}"
  aws_region             = "${var.aws_region}"
  should_be_created      = "${var.should_create_front_end_application}"
}