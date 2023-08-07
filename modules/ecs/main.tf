resource "aws_ecs_cluster" "main" {
  name = "main-cluster"
}

resource "aws_ecs_service" "go_service" {
  name            = "go-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.go_task.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id]
    security_groups = [module.security_groups.ecs_tasks_sg.id]
  }
}

resource "aws_ecs_service" "nextjs_service" {
  name            = "nextjs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nextjs_task.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets = [aws_subnet.private_subnet_2a.id, aws_subnet.private_subnet_2b.id]
    security_groups = [module.security_groups.ecs_tasks_sg.id]
  }
}

resource "aws_ecs_task_definition" "go_task" {
  family                   = "go-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = module.iam.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name  = "go-container"
    image = "go-image-url"
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
}

resource "aws_ecs_task_definition" "nextjs_task" {
  family                   = "nextjs-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = module.iam.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name  = "nextjs-container"
    image = "nextjs-image-url"
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
}