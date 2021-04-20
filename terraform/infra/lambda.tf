resource "aws_iam_role" "iam_for_lambda" {
  name = "go-lambda-docker"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_ecr_repository" "image" {
  name = "go-lambda-docker"
}

resource "aws_lambda_function" "test_lambda" {
  function_name = "go-lambda-docker"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "main"
  publish       = "true"


  runtime      = "go1.x"
  package_type = "Image"
  image_uri    = data.aws_ecr_repository.image.repository_url

  environment {
    variables = {


    }
  }
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "icebreaker_lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}


