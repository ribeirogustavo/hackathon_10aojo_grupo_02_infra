resource "aws_s3_bucket" "grupotres_bucket" {
  bucket = "grupotres_bucket"
}

resource "aws_s3_bucket_public_access_block" "grupotres_s3_access" {
  bucket = aws_s3_bucket.grupotres_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}