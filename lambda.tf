# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}

# Attach basic execution policy
resource "aws_iam_role_policy_attachment" "lambda_basic_exec" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Grant Lambda access to DynamoDB
resource "aws_iam_role_policy" "lambda_dynamodb_access" {
  name = "lambda_dynamodb_access"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Scan"
        ],
        Resource = [
          aws_dynamodb_table.jobs_table.arn,
          aws_dynamodb_table.applications_table.arn
        ]
      }
    ]
  })
}

##Deploys a Python-based Lambda function named get_jobs##
resource "aws_lambda_function" "get_jobs" {
  function_name = "get_jobs"
  runtime       = "python3.11"
  handler       = "main.lambda_handler"
  role          = aws_iam_role.lambda_exec_role.arn
  timeout       = 10

  filename         = "${path.module}/lambda/get_jobs.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda/get_jobs.zip")
}

##Deploys a Python-based Lambda function named apply_job##
resource "aws_lambda_function" "apply_job" {
  function_name = "apply_job"
  runtime       = "python3.11"
  handler       = "main.lambda_handler"
  role          = aws_iam_role.lambda_exec_role.arn
  timeout       = 10

  filename         = "${path.module}/lambda/apply_job.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda/apply_job.zip")
}


##Deploys a Python-based Lambda function named view_application##
resource "aws_lambda_function" "view_applications" {
  function_name = "view_applications"
  runtime       = "python3.11"
  handler       = "main.lambda_handler"
  role          = aws_iam_role.lambda_exec_role.arn
  timeout       = 10

  filename         = "${path.module}/lambda/view_applications.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda/view_applications.zip")
}
