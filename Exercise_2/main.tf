provider "aws" {
  access_key = ""
  secret_key = ""
  region     = var.aws_region
}

provider "archive" {}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "greet_lambda.zip"
}

resource "aws_iam_role" "iam_for_lambda_v2" {
  name = "iam_for_lambda_v2"

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

module udacity_lambda {
  source = "github.com/terraform-module/terraform-aws-lambda?ref=v2.4.0"

  function_name      = "greet_lambda"
  filename           = format("%s/%s",path.module,"greet_lambda.zip")
  description        = "udacity project2 terraform function"
  handler            = "greet_lambda.lambda_handler"
  runtime            = "python3.8"
  memory_size        = "128"
  concurrency        = "5"
  lambda_timeout     = "20"
  log_retention      = "1"
  role_arn           = aws_iam_role.iam_for_lambda_v2.arn

  environment = {
    greeting = "Hello"
  }

  tags = {
    Environment = "test"
  }
}