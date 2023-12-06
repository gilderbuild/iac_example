data "aws_secretsmanager_secret" "app_source_secret" {
  name = var.app_source_secret
}

data "aws_secretsmanager_secret_version" "app_source_secret_version" {
  secret_id = data.aws_secretsmanager_secret.app_source_secret.id
}

data "aws_secretsmanager_secret" "fe_source_secret" {
  name = var.fe_source_secret
}

data "aws_secretsmanager_secret_version" "fe_source_secret_version" {
  secret_id = data.aws_secretsmanager_secret.fe_source_secret.id
}
