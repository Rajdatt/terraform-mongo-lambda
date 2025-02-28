resource "aws_ecs_cluster" "mongo_cluster" {
  name = "mongo-cluster"
}

resource "aws_ecs_task_definition" "mongo_task" {
  family                   = "mongo-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"

  container_definitions = jsonencode([{
    name      = "mongo"
    image     = "mongo:latest"
    memory    = 512
    cpu       = 256
    essential = true
    portMappings = [{
      containerPort = 27017
      hostPort      = 27017
    }]
  }])
}

resource "aws_ecs_service" "mongo_service" {
  name            = "mongo-service"
  cluster         = aws_ecs_cluster.mongo_cluster.id
  task_definition = aws_ecs_task_definition.mongo_task.arn
  desired_count   = 1
  network_configuration {
    subnets         = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    security_groups = [aws_security_group.mongo_sg.id]
  }
}
