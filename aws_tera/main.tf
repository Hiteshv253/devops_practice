provider "aws" {
  region                      = "us-east-1"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  s3_force_path_style         = true

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
