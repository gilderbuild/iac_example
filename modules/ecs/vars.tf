
variable "ecs_cluster" {
  description = "ecs cluster that will host the services"
  type        = string
}

variable "default_tags" {
  description = "Tags to apply to resources created by this module"
  type        = map(string)
}
# ###
variable "private_subnets" {
  type = list(string)
}

variable "sgs_celery" {
  description = "security groups for celery"
  type        = list(string)
}

variable "sgs_celery_long" {
  description = "security groups for celery long"
  type        = list(string)
}

variable "sgs_celery_beat" {
  description = "security groups for celery beat"
  type        = list(string)
}

variable "sgs_be_app" {
  description = "security groups for be_app"
  type        = list(string)
}

variable "be_app_task_definition" {
  description = "be app task definition"
  type        = string
}

variable "celery_task_defintion" {
  description = "ECS tasks associated to celery "
  type        = string
}

variable "celery_long_task_defintion" {
  description = "ECS tasks associated to celery long"
  type        = string
}

variable "celery_beat_task_definition" {
  description = "ECS tasks associated to celery beat"
  type        = string
}

variable "env" {
  description = "environment"
  type        = string
}

variable "app_name" {
  description = "app name"
  type        = string
}
