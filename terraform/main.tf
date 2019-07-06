module "staging_app" {
  source        = "./modules/application"
  instance-type = "DEV1-S"
  stage         = "staging"
}

module "production_app" {
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

resource "local_file" "ansible_hosts" {
  filename = "${path.module}/../ansible/inventories/hosts"
  content = templatefile(
    "${path.module}/templates/hosts.tmpl",
    {
      staging_backend_ip     = module.staging_app.backend_ip,
      staging_frontend_ip    = module.staging_app.frontend_ip,
      staging_mysql_ip       = module.staging_app.mysql_ip,
      production_backend_ip  = module.production_app.backend_ip,
      production_frontend_ip = module.production_app.frontend_ip,
      production_mysql_ip    = module.production_app.mysql_ip,
  })
}