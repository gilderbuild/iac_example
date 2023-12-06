
resource "aws_ecs_service" "green_celery" {
  name                = "Green-BE-Celery-Workers"
  cluster             = data.aws_ecs_cluster.ecs_cluster.id
  task_definition     = data.aws_ecs_task_definition.celery.arn
  desired_count       = 0
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"
  network_configuration {
    subnets          = var.private_subnets
    security_groups  = var.sgs_celery
    assign_public_ip = true
  }
  tags = var.default_tags
}


resource "aws_ecs_service" "green_celery_long" {
  name                = "Green-BE-Celery-Worker-Long"
  cluster             = data.aws_ecs_cluster.ecs_cluster.id
  task_definition     = data.aws_ecs_task_definition.celery_long.arn
  desired_count       = 0
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"
  network_configuration {
    subnets          = var.private_subnets
    security_groups  = var.sgs_celery_long
    assign_public_ip = true
  }
  tags = var.default_tags
}

resource "aws_ecs_service" "green_celery_beat" {
  name                = "Green-BE-Celery-Worker-Beat"
  cluster             = data.aws_ecs_cluster.ecs_cluster.id
  task_definition     = data.aws_ecs_task_definition.celery_beat.arn
  desired_count       = 0
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"
  network_configuration {
    subnets          = var.private_subnets
    security_groups  = var.sgs_celery_beat
    assign_public_ip = true
  }
  tags = var.default_tags

}


resource "aws_ecs_service" "green_be_app" {
  name                              = "Green-BE-App"
  cluster                           = data.aws_ecs_cluster.ecs_cluster.id
  task_definition                   = data.aws_ecs_task_definition.be_app.arn
  desired_count                     = 0
  launch_type                       = "FARGATE"
  scheduling_strategy               = "REPLICA"
  health_check_grace_period_seconds = 60

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = var.sgs_be_app
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.tg_be_app.arn
    container_name   = "be-app"
    container_port   = 8000
  }

  tags = var.default_tags

}
