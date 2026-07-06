resource "aws_iam_role" "lambda_role" {

  name = "login-auth-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {

  role = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_vpc" {

  role = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

data "archive_file" "backend_zip" {

  type = "zip"

  source_dir = "${path.module}/backend"

  output_path = "${path.module}/backend/dist/backend.zip"
}


resource "aws_lambda_function" "signup" {

  function_name = "login-auth-signup"

  filename         = data.archive_file.backend_zip.output_path
  source_code_hash = data.archive_file.backend_zip.output_base64sha256

  role = aws_iam_role.lambda_role.arn

  runtime = "nodejs22.x"

  handler = "handlers/signup.handler"

  timeout = 15

  memory_size = 256

  vpc_config {

    subnet_ids = [
      aws_subnet.private.id
    ]

    security_group_ids = [
      aws_security_group.lambda_sg.id
    ]
  }

  environment {

    variables = {

      DB_HOST     = aws_db_instance.mysql.address
      DB_USER     = "admin"
      DB_PASSWORD = var.db_password
      DB_NAME     = "loginauth"

      JWT_SECRET = "change-this-later"

    }
  }

  depends_on = [

    aws_iam_role_policy_attachment.lambda_logs,
    aws_iam_role_policy_attachment.lambda_vpc

  ]
}


resource "aws_lambda_function" "login" {

  function_name = "login-auth-login"

  filename         = data.archive_file.backend_zip.output_path
  source_code_hash = data.archive_file.backend_zip.output_base64sha256

  role = aws_iam_role.lambda_role.arn

  runtime = "nodejs22.x"

  handler = "handlers/login.handler"

  timeout = 15

  memory_size = 256

  vpc_config {

    subnet_ids = [
      aws_subnet.private.id
    ]

    security_group_ids = [
      aws_security_group.lambda_sg.id
    ]
  }

  environment {

    variables = {

      DB_HOST     = aws_db_instance.mysql.address
      DB_USER     = "admin"
      DB_PASSWORD = var.db_password
      DB_NAME     = "loginauth"

      JWT_SECRET = "change-this-later"

    }
  }

  depends_on = [

    aws_iam_role_policy_attachment.lambda_logs,
    aws_iam_role_policy_attachment.lambda_vpc

  ]
}