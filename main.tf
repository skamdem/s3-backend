# terraform setup

terraform {
  required_version = ">= 1.5.1"

  # Remote backend specified as S3 bucket
  backend "s3" {
    bucket         = "aws-vpc-usea1-terraform-state-bucket"
    key            = "aws-vpc.tfstate" # Matches repo name.
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    #profile       = "default"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.6.2"
    }
  }
}