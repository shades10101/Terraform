/*
Create a S3 bucket first using CLI/GUI.

*/
provider "aws" {
  region = "ca-central-1"
}

resource "aws_s3_bucket" "s3backend" {
  bucket = "shades-s3-backend-2020"
  versioning {
    enabled = true
  }
  force_destroy = true
}
