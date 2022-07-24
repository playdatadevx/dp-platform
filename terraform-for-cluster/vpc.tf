data "aws_vpc" "main" {
  id = var.vpc_id
}

output "vpc_id" {
  value       = data.aws_vpc.main.id
  description = "VPC ID"
}
