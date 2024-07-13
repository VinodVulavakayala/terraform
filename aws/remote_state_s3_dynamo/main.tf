provider "aws" {
  region = "us-east-1" # Change this to your desired AWS region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "s3-bucket-state-vv" # Change this to your desired bucket name
  #acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

terraform {
  backend "s3" {
    bucket         = "s3-bucket-state-vv" # Change this to your S3 bucket name
    key            = "dev.tfstate"            # Change this to your desired state file path
    region         = "us-east-1"                 # Change this to your desired AWS region
   dynamodb_table = "terraform-lock-table"      # Change this to your DynamoDB table name
#    encrypt        = true
  }
}

# Create DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock-table" # Change this to your desired table name
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "Dev"
  }
}

resource "null_resource" "sleep" {
  provisioner "local-exec" {
    command = "sleep 120" # This will introduce a 60 seconds delay
  }
}