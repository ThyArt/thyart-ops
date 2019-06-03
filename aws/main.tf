module "application_back_end" {
  source                 = "./modules/application"
  application_name       = var.back_end_application_name
  aws_availability_zones = var.aws_availability_zones
  aws_region             = var.aws_region
}

module "application_front_end" {
  source                 = "./modules/application"
  application_name       = var.front_end_application_name
  aws_availability_zones = var.aws_availability_zones
  aws_region             = var.aws_region
}

module "staging_front_end" {
  source             = "./modules/environment/front-end"
  application_name   = module.application_front_end.name
  private_subnet_ids = module.application_front_end.private_subnets
  public_subnet_ids  = module.application_front_end.public_subnets
  route53_zone_name  = var.route53_zone_name
  stage              = "staging"
  vpc_id             = module.application_front_end.vpc
}

module "production_front_end" {
  source             = "./modules/environment/front-end"
  application_name   = module.application_front_end.name
  private_subnet_ids = module.application_front_end.private_subnets
  public_subnet_ids  = module.application_front_end.public_subnets
  route53_zone_name  = var.route53_zone_name
  stage              = "production"
  vpc_id             = module.application_front_end.vpc
}