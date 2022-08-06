resource "aws_iam_role" "eks_cluster" {
  name = "DevX"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_eks_cluster" "eks" {
  name = local.cluster_name

  role_arn = aws_iam_role.eks_cluster.arn

  version = "1.21"

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access = true
    security_group_ids = [aws_security_group.eks.id]
    subnet_ids = [
      data.aws_subnet.public_sn_a.id,
      data.aws_subnet.public_sn_b.id,
      data.aws_subnet.public_sn_c.id,
      data.aws_subnet.private_sn_a.id,
      data.aws_subnet.private_sn_b.id,
      data.aws_subnet.private_sn_c.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy, 
    aws_iam_role_policy_attachment.amazon_eks_service_policy
  ]
}

output "endpoint" {
  value = "${aws_eks_cluster.eks.endpoint}"
}