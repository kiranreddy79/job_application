resource "aws_apigatewayv2_api" "job_api" {
  name          = "job-application-api"
  protocol_type = "HTTP"
}

# Lambda invoke permissions
resource "aws_lambda_permission" "allow_get_jobs" {
  statement_id  = "AllowAPIGatewayInvokeGetJobs"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_jobs.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.job_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "allow_apply_job" {
  statement_id  = "AllowAPIGatewayInvokeApplyJob"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.apply_job.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.job_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "allow_view_applications" {
  statement_id  = "AllowAPIGatewayInvokeViewApplications"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.view_applications.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.job_api.execution_arn}/*/*"
}

# Lambda integrations
resource "aws_apigatewayv2_integration" "get_jobs" {
  api_id             = aws_apigatewayv2_api.job_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.get_jobs.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "apply_job" {
  api_id             = aws_apigatewayv2_api.job_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.apply_job.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "view_applications" {
  api_id             = aws_apigatewayv2_api.job_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.view_applications.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

# API routes
resource "aws_apigatewayv2_route" "get_jobs" {
  api_id    = aws_apigatewayv2_api.job_api.id
  route_key = "GET /jobs"
  target    = "integrations/${aws_apigatewayv2_integration.get_jobs.id}"
}

resource "aws_apigatewayv2_route" "apply_job" {
  api_id    = aws_apigatewayv2_api.job_api.id
  route_key = "POST /apply"
  target    = "integrations/${aws_apigatewayv2_integration.apply_job.id}"
}

resource "aws_apigatewayv2_route" "view_applications" {
  api_id    = aws_apigatewayv2_api.job_api.id
  route_key = "GET /admin/applications"
  target    = "integrations/${aws_apigatewayv2_integration.view_applications.id}"
}

# Deploy stage
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.job_api.id
  name        = "$default"
  auto_deploy = true
}