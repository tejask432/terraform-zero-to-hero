terraform {
  backend "s3" {
    bucket         = "mybucket-0010101093993"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_lock"
  }
}