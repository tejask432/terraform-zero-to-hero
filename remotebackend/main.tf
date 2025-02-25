terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.5.0"
    }
  }
  required_version = "~> 1.2"
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket        = "mybucket-0010101093993"
  force_destroy = true
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}