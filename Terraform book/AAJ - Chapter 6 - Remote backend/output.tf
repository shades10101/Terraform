terraform {
  backend "s3" {
      bucket = "shades-s3-backend-2020"
      key = "terraform/tfstate"
      region = "ca-central-1"
  }
}

// Once you create this after the S3 bucket on
// Terrafom, run a terraform init
// terraform init -reconfigure \
//    -backend-config="bucket="${BUCKET}"" \
//    -backend-config="key="${SERVICE_NAME}""
// https://medium.com/@maciejmatecki/terraform-chicken-egg-problem-7504f8ddf2fc