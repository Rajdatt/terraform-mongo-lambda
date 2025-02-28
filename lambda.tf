resource "aws_lambda_function" "mongo_lambda" {
  function_name    = "mongoQueryLambda"
  role            = aws_iam_role.lambda_role.arn
  runtime        = "nodejs18.x"
  handler        = "index.handler"
  memory_size    = 128
  timeout        = 10
  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    security_group_ids = [aws_security_group.mongo_sg.id]
  }

  filename         = "lambda.zip" # ZIP containing Node.js code
  source_code_hash = filebase64sha256("lambda.zip")
}
