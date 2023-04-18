provider "aws" {
    region = "us-east-1"
    access_key = var.MY_ACCESS_KEY
    secret_key = var.MY_SECRET_KEY
}

resource "aws_s3_bucket" "JuOspina-bucket" {
    bucket = "juospina-bucket"
    tags = {
        Name = "juospina-bucket"
    }
    force_destroy= true
}

resource "aws_s3_bucket_acl" "JuOspina-bucket-acl" {
    bucket = aws_s3_bucket.JuOspina-bucket.id
    acl = var.bucket_acl
  
}

terraform {
  backend "s3" {
    bucket = "juospina-bucket"
    key    = "global"
    region = "us-east-1"
  }
}