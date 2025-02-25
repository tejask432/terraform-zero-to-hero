resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-08091998"
  force_destroy = true
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
output "bucket_id" {
  value = aws_s3_bucket.example.id
}
