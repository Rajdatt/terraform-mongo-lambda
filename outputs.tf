output "lambda_function_name" {
  value = aws_lambda_function.mongo_lambda.function_name
}

output "mongo_ecs_service" {
  value = aws_ecs_service.mongo_service.name
}
