output "rds_endpoint" {
  value = aws_db_instance.mysql.address
}

output "rds_port" {
  value = aws_db_instance.mysql.port
}

output "api_gateway_url" {
  value = aws_api_gateway_stage.dev.invoke_url
}

output "signup_endpoint" {
  value = "${aws_api_gateway_stage.dev.invoke_url}/signup"
}

output "login_endpoint" {
  value = "${aws_api_gateway_stage.dev.invoke_url}/login"
}

output "alb_dns_name" {
  value = aws_lb.frontend_alb.dns_name
}