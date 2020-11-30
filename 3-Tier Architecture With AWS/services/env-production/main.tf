# Configure provider
provider "aws" {
  region = "ca-central-1"
}

# Pin AWS Plugin version
terraform {
  # Configure S3 bucker for state
  backend "s3" {
    bucket         = "tf-prod-state-bucket-031494"
    key            = "global/s3/dev/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "tf-dev-state-lock"
    encrypt        = true
  }
}

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
    Terraform   = "true"
  }
}

# Configure aws dynamodb table for state locks
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tf-prod-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = "Prod"
    Terraform   = "true"
  }
}

module "network" {
  source                = "../modules/aws-network"
  vpc_cidr              = var.vpc_cidr
  public_subnet_b_cidr  = var.public_subnet_b_cidr
  public_subnet_c_cidr  = var.public_subnet_c_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
  private_subnet_c_cidr = var.private_subnet_c_cidr
  db_subnet_b_cidr      = var.db_subnet_b_cidr
  db_subnet_c_cidr      = var.db_subnet_c_cidr
}

module "web" {
  source           = "../modules/aws-web"
  public_subnet_b  = module.network.public_subnet_b
  public_subnet_c  = module.network.public_subnet_c
  private_subnet_b = module.network.private_subnet_b
  private_subnet_c = module.network.private_subnet_c
  public_sg        = module.network.public_sg
  private_sg       = module.network.private_sg
  ami              = var.ami
  instance_type    = var.instance_type
}

module "db" {
  source              = "../modules/aws-db"
  db_subnet_b         = module.network.db_subnet_b
  db_subnet_c         = module.network.db_subnet_c
  db_security_group   = module.network.private_sg
  username            = var.username
  password            = var.password
  instance_class      = var.instance_class
  multi_az            = var.multi_az
  allocated_storage   = var.allocated_storage
  skip_final_snapshot = var.skip_final_snapshot
}