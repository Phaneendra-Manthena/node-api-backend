locals {
  tags = {
    Name = "timing-api-backend"
    Environment = "dev"
    Terraform = "true"
  }
  rds_secret_srn = data.aws_ssm_parameter.rds_secret_srn.value
  app_alb_security_group_id = data.aws_ssm_parameter.app_alb_security_group_id.value
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}