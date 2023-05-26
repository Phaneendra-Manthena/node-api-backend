data "aws_iam_policy_document" "ecs-trust" {
    statement {
      sid = "ECSTrustPolicy"
      actions = ["sts:AssumeRole"]
      principals {
        type = "Service"
        identifiers = ["ecs-tasks.amazonaws.com"]
      }
    }
}
data "aws_iam_policy_document" "rds_secret" {
  statement {
    sid = "AllowECStoAccessRDSSecret"
    actions = [
        "secretsmanager:GetSecretValue"
    ]
    resources = ["${local.rds_secret_srn}"]
  }
}
data "aws_ssm_parameter" "rds_secret_srn" {
  name = "/timing/rds/rds_secret_srn"
}

data "aws_ssm_parameter" "app_alb_security_group_id" {
  name = "/timing/vpc/app_alb_security_group_id"
}
data "aws_ssm_parameter" "vpc_id" {
  name = "/timing/vpc/vpc_id"
}
data "aws_ssm_parameter" "rds_endpoint" {
  name = "/timing/rds/rds_endpoint"
}
data "aws_ssm_parameter" "rds_security_group_id" {
  name = "/timing/vpc/rds_security_group_id"
}
data "aws_ssm_parameter" "ecs_cluster_id" {
  name = "/timing/ecs/ecs_cluster_id"
}
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/timing/vpc/private_subnet_ids"
}
  data "aws_ssm_parameter" "app_target_group_arn" {
  name = "/timing/app/app_target_group_arns"
}