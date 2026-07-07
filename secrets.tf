resource "aws_secretsmanager_secret" "login_auth" {
  name = "login-auth-secret"

  tags = {
    Name = "login-auth-secret"
  }
}

resource "aws_secretsmanager_secret_version" "login_auth" {
  secret_id = aws_secretsmanager_secret.login_auth.id

  secret_string = jsonencode({
    DB_HOST     = aws_db_instance.mysql.address
    DB_USER     = "admin"
    DB_PASSWORD = var.db_password
    DB_NAME     = "loginauth"
    JWT_SECRET  = "change-this-later"
  })
}