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