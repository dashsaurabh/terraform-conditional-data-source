provider "aws" {
    region = "us-west-2"
    profile = "terraform-user"
}

resource "aws_s3_bucket" "dev_bucket" {
  bucket = "saurabh-dev-bucket-2023-01-19"
}

resource "aws_s3_bucket" "prod_bucket" {
  bucket = "saurabh-prod-bucket-2023-01-19"
}

data "aws_s3_bucket" "example" {
  bucket = var.environment == "production" ? aws_s3_bucket.prod_bucket.bucket : aws_s3_bucket.dev_bucket.bucket
}

variable "environment" {
  type = string
  default = "development"
}

resource "aws_s3_object" "example" {
  bucket = data.aws_s3_bucket.example.bucket
  key    = "demo.txt"
  source = "demo.txt"
}

output "s3_bucket_name" {
  value = data.aws_s3_bucket.example.bucket
}