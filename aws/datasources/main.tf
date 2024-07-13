provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "vinod-bucket-name-1"
    key    = "filename"
    region = "us-west-1"
  }
}

data "aws_s3_bucket" "example" {
  bucket = "vinod-bucket-name-1"
}

output "s3_bucket_name" {
    value = data.aws_s3_bucket.example.bucket
  
}
output "bucket_region" {

    value = data.aws_s3_bucket.example.region
  
}