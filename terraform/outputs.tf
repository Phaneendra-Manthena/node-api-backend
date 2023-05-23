output "rds_endpoint" {
  value     = local.rds_endpoint
  sensitive = true
}

output "rds_secret_srn" {
  value     = local.rds_secret_srn
  sensitive = true
}
