resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow HTTP traffic from Internet"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-security-group"
  }
}

resource "aws_security_group" "ec2_sg" {

  name        = "ec2-security-group"
  description = "Allow traffic only from ALB"

  vpc_id = aws_vpc.main.id

  ingress {

    description = "HTTP from ALB"

    from_port = 80
    to_port   = 80

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb_sg.id
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "ec2-security-group"
  }
}

resource "aws_security_group" "rds_sg" {

  name = "rds-security-group"

  description = "Allow MySQL only from EC2"

  vpc_id = aws_vpc.main.id

  ingress {

    description = "MySQL"

    from_port = 3306
    to_port   = 3306

    protocol = "tcp"

    security_groups = [
      aws_security_group.ec2_sg.id,
      aws_security_group.lambda_sg.id
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "rds-security-group"
  }
}

resource "aws_security_group" "endpoint_sg" {

  name        = "vpc-endpoint-sg"
  description = "Allow HTTPS from private subnet"

  vpc_id = aws_vpc.main.id

  ingress {

    from_port = 443
    to_port   = 443

    protocol = "tcp"

    cidr_blocks = [
      "10.0.2.0/24"
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "endpoint-security-group"
  }
}

resource "aws_security_group" "lambda_sg" {

  name        = "lambda-security-group"
  description = "Lambda Security Group"

  vpc_id = aws_vpc.main.id

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "lambda-security-group"
  }
}