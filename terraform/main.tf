module "staging-app" {
  source        = "./modules/application"
  instance-type = "DEV1-S"
  stage         = "staging"
}

module "production-app" {
  source        = "./modules/application"
  instance-type = "DEV1-S"
  stage         = "production"
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