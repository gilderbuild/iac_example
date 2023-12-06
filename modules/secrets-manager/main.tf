resource "aws_secretsmanager_secret" "app_target_secret" {
  name                    = var.app_target_secret
  recovery_window_in_days = 0
  tags                    = var.default_tags
}

resource "aws_secretsmanager_secret_version" "app_target_secret_version" {
  secret_id     = aws_secretsmanager_secret.app_target_secret.id
  secret_string = data.aws_secretsmanager_secret_version.app_source_secret_version.secret_string
}

resource "aws_secretsmanager_secret" "fe_target_secret" {
  name                    = var.fe_target_secret
  recovery_window_in_days = 0
  tags                    = var.default_tags
}

resource "aws_secretsmanager_secret_version" "fe_target_secret_version" {
  secret_id     = aws_secretsmanager_secret.fe_target_secret.id
  secret_string = data.aws_secretsmanager_secret_version.fe_source_secret_version.secret_string
}
