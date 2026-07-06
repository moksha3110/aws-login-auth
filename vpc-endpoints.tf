resource "aws_vpc_endpoint" "ssm" {

  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.us-east-1.ssm"

  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private.id
  ]

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "ssm-endpoint"
  }

}

resource "aws_vpc_endpoint" "ssmmessages" {

  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.us-east-1.ssmmessages"

  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private.id
  ]

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "ssmmessages-endpoint"
  }

}

resource "aws_vpc_endpoint" "ec2messages" {

  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.us-east-1.ec2messages"

  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.private.id
  ]

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "ec2messages-endpoint"
  }

}