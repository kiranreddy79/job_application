output "s3_bucket_name" {
  description = "Name of the S3 bucket for frontend"
  value       = aws_s3_bucket.frontend_bucket.bucket
}

output "s3_bucket_website_url" {
  description = "Static website URL for the frontend"
  value       = aws_s3_bucket.frontend_bucket.website_endpoint
}

output "dynamodb_jobs_table_name" {
  description = "DynamoDB table name for job listings"
  value       = aws_dynamodb_table.jobs_table.name
}

output "dynamodb_applications_table_name" {
  description = "DynamoDB table name for job applications"
  value       = aws_dynamodb_table.applications_table.name
}

output "api_gateway_endpoint" {
  description = "Base URL of the API Gateway"
  value       = aws_apigatewayv2_api.job_api.api_endpoint
}
