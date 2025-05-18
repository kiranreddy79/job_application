resource "aws_dynamodb_table" "jobs_table" {
  name         = "job_listings"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "job_id"

  attribute {
    name = "job_id"
    type = "S"
  }

  tags = {
    Name = "JobsTable"
  }
}

resource "aws_dynamodb_table" "applications_table" {
  name         = "job_applications"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "application_id"

  attribute {
    name = "application_id"
    type = "S"
  }

  tags = {
    Name = "ApplicationsTable"
  }
}

