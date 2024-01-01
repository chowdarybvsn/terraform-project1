resource "aws_s3_bucket" "bucket_project" {
    bucket = var.s3_bucket_name
}
resource "aws_s3_bucket_acl" "acl" {
     bucket = aws_s3_bucket.bucket_project.bucket
     acl = "private"
}
resource "aws_s3_bucket_public_access_block" "acc_block"{
   bucket = aws_s3_bucket.bucket_project.bucket

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.bucket_project.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.bucket_project.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.bucket_project.id
  versioning_configuration {
    status = "Enabled"
  }
}