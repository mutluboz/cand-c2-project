# TODO: Define the output variable for the lambda function.

output "lambda_arn" {
  value = module.udacity_lambda.arn
}