resource "aws_vpc" "main" {

  cidr_block = "192.168.0.0/16"

  instance_tenancy = "default" # Makes your instances shared on the host

  enable_dns_support   = true # DNS support enable  (EKS required)
  enable_dns_hostnames = true # DNS hostnames enable  (EKS required)

  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "${local.cluster_name}-vpc"
  }
}


output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}



