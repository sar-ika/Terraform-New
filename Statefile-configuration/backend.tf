terraform {
  backend "s3" {
    bucket = "sarhjklgn"
    key    = "terraform.tfstate"
    region = "us-east-1"
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
dynamodb_table = "terraform-state-lock-dynamo"
  }
}
