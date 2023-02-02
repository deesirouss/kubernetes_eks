resource "aws_secretsmanager_secret" "auth_api" {
  name                    = join("/", ["np-vyaguta", "auth", "api", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "core_api" {
  name                    = join("/", ["np-vyaguta", "core", "api", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "core_app" {
  name                    = join("/", ["np-vyaguta", "core", "app", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "jump_api" {
  name                    = join("/", ["np-vyaguta", "jump", "api", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "jump_app" {
  name                    = join("/", ["np-vyaguta", "jump", "app", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "leave_api" {
  name                    = join("/", ["np-vyaguta", "leave", "api", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "leave_app" {
  name                    = join("/", ["np-vyaguta", "leave", "app", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "teams_api" {
  name                    = join("/", ["np-vyaguta", "teams", "api", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "teams_app" {
  name                    = join("/", ["np-vyaguta", "teams", "app", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "okr_api" {
  name                    = join("/", ["np-vyaguta", "okr", "api", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "okr_app" {
  name                    = join("/", ["np-vyaguta", "okr", "app", local.secret_stage])
  recovery_window_in_days = 0
}
resource "aws_secretsmanager_secret" "rnr_api" {
  name                    = join("/", ["np-vyaguta", "rnr", "api", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "rnr_app" {
  name                    = join("/", ["np-vyaguta", "rnr", "app", local.secret_stage])
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "organization-chart_app" {
  name                    = join("/", ["np-vyaguta", "organization-chart", "app", local.secret_stage])
  recovery_window_in_days = 0
}

data "aws_iam_policy_document" "aws_secrets" {
  statement {
    actions = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
    ]
    resources = [
      aws_secretsmanager_secret.auth_api.arn,
      aws_secretsmanager_secret.core_api.arn,
      aws_secretsmanager_secret.core_app.arn,
      aws_secretsmanager_secret.jump_api.arn,
      aws_secretsmanager_secret.jump_app.arn,
      aws_secretsmanager_secret.leave_api.arn,
      aws_secretsmanager_secret.leave_app.arn,
      aws_secretsmanager_secret.teams_api.arn,
      aws_secretsmanager_secret.teams_app.arn,
      aws_secretsmanager_secret.okr_api.arn,
      aws_secretsmanager_secret.okr_app.arn,
      aws_secretsmanager_secret.rnr_api.arn,
      aws_secretsmanager_secret.rnr_app.arn,
      aws_secretsmanager_secret.organization-chart_app.arn
    ]
  }
}

resource "aws_iam_policy" "aws_secrets" {
  name = join("-", [
  local.secret_stage, var.environment, "secret-manager-policy"])
  policy = data.aws_iam_policy_document.aws_secrets.json
  tags = local.tags
}
