terraform {
  backend "s3" {
    bucket = "my-tf-test-bucket-08091998"
    key    = "mydemo/terraform.tfstate"
    region = "us-east-1"
  }
}