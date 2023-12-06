locals {
  env = {
    default = {
      app_name                    = "zero-downtime"
      cert_name                   = "myapp.com"
      celery_task_defintion       = "Celery-Workers"
      celery_long_task_defintion  = "Celery-Worker-Long"
      celery_beat_task_definition = "Celery-Beat"
      default_tags = {
        Terraform = true
        app_name  = "zero-downtime"
      }
    },
    prod = {
      env                       = "prod"
      secret_be_app          = "prod/be-app/settings"
      secret_frontend           = "frontend/build"
      env_full_name             = "production"
      public_subnets            = ["subnet-123445adsf", "subnet-123445adf"]
      vpc_id                    = "vpc-123445adsf"
      private_subnets           = ["subnet-123445adsf", "subnet-123445adsfa", "subnet-123445adsf"]
      sgs_celery                = ["sg-asdf"]
      sgs_celery_long           = ["sg-123445adsf"]
      sgs_celery_beat           = ["sg-123445afda"]
      sgs_be_app             = ["sg-0d3c6b1a694b332bb"]
      vpc_id                    = "vpc-123445adsf"
      ecs_cluster               = "ECSPipeline-prod-Cluster-ID"
      be_app_task_definition = "ECSPipeline-prod-Service-ID-be-app"
    },
    dev = {
      env                       = "dev"
      secret_be_app          = "dev/be-app/settings"
      secret_frontend           = "frontend/build"
      env_full_name             = "development"
      public_subnets            = ["subnet-123445adfa", "subnet-123445adfa"]
      private_subnets           = ["subnet-123445adf", "subnet-123445adsf", "subnet-123445asdf"]
      sgs_celery                = ["sg-123445adfa"]
      sgs_celery_long           = ["sg-123445adf"]
      sgs_celery_beat           = ["sg-123445adf"]
      sgs_be_app             = ["sg-123445adfa"]
      vpc_id                    = "vpc-123445adfa"
      ecs_cluster               = "ECSPipeline-Cluster-ID123445"
      be_app_task_definition = "ECSPipeline-Service-1A39BQXC7N7G7-be-app"
    },
    stg = {
      env              = "stg"
      secret_be_app = "staging/be-app/settings"
      secret_frontend  = "frontend/build"
      env_full_name    = "staging"
      public_subnets   = ["subnet-123445adf", "subnet-123445asdfa"]

      private_subnets           = ["subnet-123445asdf", "subnet-123445adfas", "subnet-123445asdf"]
      sgs_celery                = ["sg-123456"]
      sgs_celery_long           = ["sg-123445"]
      sgs_celery_beat           = ["sg-123445dadf"]
      sgs_be_app             = ["sg-123445eadf"]
      vpc_id                    = "vpc-123445adsfas"
      ecs_cluster               = "ECSPipeline-Staging-Cluster-ID"
      be_app_task_definition = "ECSPipeline-Staging-Service-KPQG633DDELJ-be-app"
    },

    rc = {
      env              = "rc"
      app_name         = "zero-downtime"
      secret_be_app = "rc/be-app/settings"
      secret_frontend  = "rc/frontend/build"
      env_full_name    = "release-candidate"
      public_subnets   = ["subnet-123445adfa", "subnet-123445dafda", "subnet-123445adfadf"]
      private_subnets  = ["subnet-123445adfa", "subnet-00e18f7efe85549ae", "subnet-123445adfa"]
      sgs_celery       = ["sg-123445ada"]
      sgs_celery_long  = ["sg-123445adas"]
      sgs_celery_beat  = ["sg-123445adsf"]
      sgs_be_app    = ["sg-123445adas"]
      vpc_id           = "vpc-123445adasfd"
      ecs_cluster      = "release-candidate"

      be_app_task_definition   = "rc-be-app"
      celery_task_defintion       = "rc-be-celery-workers"
      celery_long_task_defintion  = "rc-be-celery-worker-long"
      celery_beat_task_definition = "rc-be-celery-beat"
    }

  }
  environmentvars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace       = merge(local.env["default"], local.env[local.environmentvars])
}

locals {
  env_suffix_non_prod = local.workspace["env"] == "prod" ? "" : "-${local.workspace["env"]}"
}
