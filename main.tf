module "ec2" {
  source              = "./modules/ec2"
  app_name            = local.workspace["app_name"]
  vpc_id              = local.workspace["vpc_id"]
  public_subnets      = local.workspace["public_subnets"]
  cert_name           = local.workspace["cert_name"]
  env                 = local.workspace["env"]
  env_full_name       = local.workspace["env_full_name"]
  env_suffix_non_prod = local.env_suffix_non_prod
  default_tags        = local.workspace["default_tags"]
}

module "secrets" {
  source            = "./modules/secrets-manager"
  app_source_secret = local.workspace["secret_be_app"]
  app_target_secret = "${local.workspace["env"]}/be-app-green/settings"
  fe_source_secret  = local.workspace["secret_frontend"]
  fe_target_secret  = "${local.workspace["env"]}/frontend-green"
  default_tags      = local.workspace["default_tags"]
}

module "ecs" {
  source                      = "./modules/ecs"
  ecs_cluster                 = local.workspace["ecs_cluster"]
  private_subnets             = local.workspace["private_subnets"]
  sgs_celery                  = local.workspace["sgs_celery"]
  sgs_celery_long             = local.workspace["sgs_celery_long"]
  sgs_celery_beat             = local.workspace["sgs_celery_beat"]
  celery_task_defintion       = local.workspace["celery_task_defintion"]
  celery_long_task_defintion  = local.workspace["celery_long_task_defintion"]
  celery_beat_task_definition = local.workspace["celery_beat_task_definition"]
  sgs_be_app               = local.workspace["sgs_be_app"]
  be_app_task_definition   = local.workspace["beapp_task_definition"]
  env                         = local.workspace["env"]
  app_name                    = local.workspace["app_name"]
  default_tags                = local.workspace["default_tags"]
}
