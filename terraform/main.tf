module "staging_app" {
  source                = "./modules/application"
  instance-type         = "DEV1-S"
  stage                 = "staging"
  backend_cname_prefix  = "staging.api"
  frontend_cname_prefix = "staging"
  mysql_cname_prefix    = "staging.db"
}

module "production_app" {
  source                = "./modules/application"
  instance-type         = "DEV1-S"
  stage                 = "production"
  backend_cname_prefix  = "api"
  frontend_cname_prefix = "www"
  mysql_cname_prefix    = "db"
}

module "documentation" {
  source        = "./modules/documentation"
  instance-type = "DEV1-S"
  cname_prefix  = "doc.api"
}

resource "github_branch_protection" "protection_master" {
  count      = length(data.github_repository.repositories)
  branch     = "master"
  repository = data.github_repository.repositories[count.index].name
}

resource "github_branch_protection" "protection_dev" {
  count      = length(data.github_repository.repositories)
  branch     = "dev"
  repository = data.github_repository.repositories[count.index].name
}