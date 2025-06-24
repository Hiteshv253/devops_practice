provider "aws" {
  region                      = "us-east-1"
  access_key                  = "mock"
  secret_key                  = "mock"
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "local_test_bucket" {
  bucket = "localstack-terratest-bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.local_test_bucket.bucket
}
