provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "aws-login-auth"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}