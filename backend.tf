# colgatepalmolive-terraform-iac/cp-aws-us-east-1

resource "aws_s3_bucket" "tf_remote_state_bucket" {
  bucket = "aws-vpc-usea1-terraform-state-bucket"
  lifecycle {
    prevent_destroy = true
  }
}

# Enable versioning so we can see the full revision history of our
# state files
resource "aws_s3_bucket_versioning" "tf_remote_state_bucket" {
  bucket = aws_s3_bucket.tf_remote_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "tf_remote_state_bucket" {
  bucket = aws_s3_bucket.tf_remote_state_bucket.id
  rule {
    id     = "rax-cleanup-incomplete-mpu-objects"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }

    filter {
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.tf_remote_state_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_remote_state_bucket" {
  bucket = aws_s3_bucket.tf_remote_state_bucket.id
  # Enable server-side encryption by default
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#locking part
resource "aws_dynamodb_table" "tf_remote_state_bucket_locking" {
  hash_key     = "LockID"
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.tf_remote_state_bucket.arn
  description = "The ARN of the S3 bucket"
}
output "dynamodb_table_name" {
  value       = aws_dynamodb_table.tf_remote_state_bucket_locking.name
  description = "The name of the DynamoDB table"
}

terraform {
  required_version = "1.4.2"
  backend "s3" {
    bucket         = "aws-vpc-usea1-terraform-state-bucket"
    key            = "aws-vpc.tfstate" # Matches repo name.
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    #profile       = "default"
  }
}
