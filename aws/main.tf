resource "tls_private_key" "reg_private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.reg_private_key.private_key_pem
  email_address   = var.acme_registration_email
}

resource "acme_certificate" "certificate" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = local.cnames.web_prod
  subject_alternative_names = [
    local.cnames.web_staging,
    local.cnames.api_prod,
    local.cnames.api_staging
  ]

  dns_challenge {
    provider = "route53"
  }
}

resource "aws_iam_server_certificate" "iam_certificate" {
  name             = local.cnames.web_prod
  certificate_body = acme_certificate.certificate.certificate_pem
  private_key      = acme_certificate.certificate.private_key_pem
}

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
  certificate_name   = aws_iam_server_certificate.iam_certificate.name
  environment_cname  = local.cnames.web_staging
}

module "production_front_end" {
  source             = "./modules/environment/front-end"
  application_name   = module.application_front_end.name
  private_subnet_ids = module.application_front_end.private_subnets
  public_subnet_ids  = module.application_front_end.public_subnets
  route53_zone_name  = var.route53_zone_name
  stage              = "production"
  vpc_id             = module.application_front_end.vpc
  certificate_name   = aws_iam_server_certificate.iam_certificate.name
  environment_cname  = local.cnames.web_prod
}