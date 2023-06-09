resource "aws_ecs_task_definition" "api" {
    family = "${local.tags.Name}"
    execution_role_arn = aws_iam_role.api_role_task_execution.arn
    task_role_arn = aws_iam_role.api_role-task.arn
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = 1024
    memory = 2048
    container_definitions = <<TASK_DEFINITION
    [
        {
        
            "essential": true,
            "image": "347554562486.dkr.ecr.us-east-1.amazonaws.com/node-app-backend:latest",
            "name": "${local.container_name}",
            "portMappings": [
                {
                    "containerPort": 3000
                }
            ],
            "logConfiguration": {
                "logDriver": "awslogs",
                 "options": {
                  "awslogs-group": "${aws_cloudwatch_log_group.api.name}",
                  "awslogs-region": "us-east-1",
                   "awslogs-stream-prefix": "ecs-api"
                }
            },       
            "environment" : ${jsonencode(local.env_vars)},
            "secrets": ${jsonencode(local.application_secrets)}
            
        }
    ]
    TASK_DEFINITION
}

resource "aws_ecs_service" "api" {
name = "${local.tags.Name}"
cluster = local.ecs_cluster_id
task_definition = aws_ecs_task_definition.api.arn
desired_count = 2
launch_type = "FARGATE"
network_configuration {
  subnets = local.private_subnet_ids
  security_groups = [aws_security_group.api_ecs.id]
}
load_balancer {
  target_group_arn = local.app_target_group_arn
  container_name = local.container_name
  container_port = 3000
}
}
resource "aws_cloudwatch_log_group" "api" {
  name = "timing/ecs/api"
  tags = local.tags
}