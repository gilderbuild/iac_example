data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = var.ecs_cluster
}

data "aws_ecs_task_definition" "celery" {
  task_definition = var.celery_task_defintion
}

data "aws_ecs_task_definition" "celery_long" {
  task_definition = var.celery_long_task_defintion
}

data "aws_ecs_task_definition" "celery_beat" {
  task_definition = var.celery_beat_task_definition
}

data "aws_ecs_task_definition" "be_app" {
  task_definition = var.be_app_task_definition
}

data "aws_iam_role" "service_role" {
  name = "AWSServiceRoleForECS"
}

data "aws_lb_target_group" "tg_be_app" {
  name = "${var.env}-${var.app_name}"
}
