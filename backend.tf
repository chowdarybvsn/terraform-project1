terraform {
  backend "s3" {
    bucket = "terraform-project-1-2023"
    key    = "state/backend.tfstate"
    region = "us-east-1"
    dynamodb_table = "dynamodb-2024"
  }
}
