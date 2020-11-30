# Configure provider
provider "aws" {
    region = "ca-central-1"
}

/*# Pin AWS Plugin version
terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.0.0"
      }
  }

Configure S3 bucker for state
required_version = "~> 0.13.0"

    backend "S3" {
        Bucket = "tf-dev-state-bucket-031494"
        key =  "global/s3/dev/terraform.tfstate"
        region = "ca-central-1"
        dynamodb_table = "tf-dev-state-lock"
        encrypt = true
    }
} */

# Configure S3 Bucket
resource "aws_s3_bucket" "state_tf" {
    bucket = "tf-prod-state-bucket-031494"

    lifecycle {
        prevent_destroy = true
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }

tags = {
    Environment = "Prod"
    Terraform = "true"
    }
}

# Configure aws dynamodb table for state locks
resource "aws_dynamodb_table" "terraform_locks" {
    name = "tf-prod-state-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }

    tags = {
        Environment = "Prod"
        Terraform = "true"
    }
}