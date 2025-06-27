terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
    region = var.aws_region
  # Optionally specify credentials here, but AWS recommended to use env vars or profiles
   access_key = "YOUR_ACCESS_KEY"
   secret_key = "YOUR_SECRET_KEY"
  
}

resource "random_pet" "suffix" {
  length    = 2
  separator = "-"
}

# S3 Buckets
resource "aws_s3_bucket" "prod" {
  bucket = "${var.bucket_prefix}-prod-${random_pet.suffix.id}"
  acl    = "private"
}

resource "aws_s3_bucket" "qa" {
  bucket = "${var.bucket_prefix}-qa-${random_pet.suffix.id}"
  acl    = "private"
}

resource "aws_s3_bucket" "dev" {
  bucket = "${var.bucket_prefix}-dev-${random_pet.suffix.id}"
  acl    = "private"
}

# IAM Users
resource "aws_iam_user" "prod_user" {
  name = "${var.bucket_prefix}-user-prod"
}

resource "aws_iam_user" "qa_user" {
  name = "${var.bucket_prefix}-user-qa"
}

resource "aws_iam_user" "dev_user" {
  name = "${var.bucket_prefix}-user-dev"
}

# Access Keys
resource "aws_iam_access_key" "prod_user_key" {
  user = aws_iam_user.prod_user.name
}

resource "aws_iam_access_key" "qa_user_key" {
  user = aws_iam_user.qa_user.name
}

resource "aws_iam_access_key" "dev_user_key" {
  user = aws_iam_user.dev_user.name
}

# IAM Policy Documents
#ARN = amazon resource name
data "aws_iam_policy_document" "prod_read" {
  statement {
    effect = "Allow"
    actions = ["s3:GetObject", "s3:ListBucket"]
    resources = [
      aws_s3_bucket.prod.arn,
      "${aws_s3_bucket.prod.arn}/prod/*"
    ]
  }
}

data "aws_iam_policy_document" "qa_full" {
  statement {
    effect = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.qa.arn,
      "${aws_s3_bucket.qa.arn}/qa/*"
    ]
  }
}

data "aws_iam_policy_document" "dev_full" {
  statement {
    effect = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.dev.arn,
      "${aws_s3_bucket.dev.arn}/dev/*"
    ]
  }
}

# Policies
resource "aws_iam_policy" "prod_read_policy" {
  name   = "${var.bucket_prefix}-prod-read"
  policy = data.aws_iam_policy_document.prod_read.json
}

resource "aws_iam_policy" "qa_full_policy" {
  name   = "${var.bucket_prefix}-qa-full"
  policy = data.aws_iam_policy_document.qa_full.json
}

resource "aws_iam_policy" "dev_full_policy" {
  name   = "${var.bucket_prefix}-dev-full"
  policy = data.aws_iam_policy_document.dev_full.json
}

# Attach Policies
resource "aws_iam_user_policy_attachment" "prod_attach" {
  user       = aws_iam_user.prod_user.name
  policy_arn = aws_iam_policy.prod_read_policy.arn
}

resource "aws_iam_user_policy_attachment" "qa_attach" {
  user       = aws_iam_user.qa_user.name
  policy_arn = aws_iam_policy.qa_full_policy.arn
}

resource "aws_iam_user_policy_attachment" "dev_attach" {
  user       = aws_iam_user.dev_user.name
  policy_arn = aws_iam_policy.dev_full_policy.arn
}

# Outputs
output "prod_user_credentials" {
  sensitive = true
  value = {
    access_key_id     = aws_iam_access_key.prod_user_key.id
    secret_access_key = aws_iam_access_key.prod_user_key.secret
  }
}

output "qa_user_credentials" {
  sensitive = true
  value = {
    access_key_id     = aws_iam_access_key.qa_user_key.id
    secret_access_key = aws_iam_access_key.qa_user_key.secret
  }
}

output "dev_user_credentials" {
  sensitive = true
  value = {
    access_key_id     = aws_iam_access_key.dev_user_key.id
    secret_access_key = aws_iam_access_key.dev_user_key.secret
  }
}

output "bucket_names" {
  value = {
    prod = aws_s3_bucket.prod.bucket
    qa   = aws_s3_bucket.qa.bucket
    dev  = aws_s3_bucket.dev.bucket
  }
}
