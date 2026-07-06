resource "aws_db_subnet_group" "main" {
  name = "login-auth-db-subnet-group"

  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "login-auth-db-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {

  identifier = "login-auth-db"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = "loginauth"
  username = "admin"
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  publicly_accessible = false

  skip_final_snapshot = true

  deletion_protection = false

  tags = {
    Name = "login-auth-mysql"
  }
}