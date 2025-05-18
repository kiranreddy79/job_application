resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "job-portal-frontend-${random_id.suffix.hex}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name        = "JobPortalFrontend"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "frontend_access" {
  bucket = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.frontend_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "PublicReadGetObject"
      Effect    = "Allow"
      Principal = "*"
      Action    = ["s3:GetObject"]
      Resource  = "${aws_s3_bucket.frontend_bucket.arn}/*"
    }]
  })
}


resource "aws_s3_object" "frontend_index" {
  bucket        = aws_s3_bucket.frontend_bucket.id  
  key           = "index.html"
  source        = "${path.module}/frontend/index.html"
  etag          = filemd5("${path.module}/frontend/index.html")
  content_type  = "text/html"
}


