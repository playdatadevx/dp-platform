resource "aws_security_group" "eks" {
	name = "eks-sg"
	description = "Cluster communication with worker nodes"
	vpc_id = data.aws_vpc.main.id

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "eks-sg"
	}
}

resource "aws_security_group_rule" "eks_cluster_jumpbox_node" {
  description              = "Allow jumpbox to communicate with workernode."
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks.id
  source_security_group_id = "sg-0dd3d4a277c1c00fb"
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group" "worker" {
  name        = "eks-worker-sg"
  description = "Security group for all nodes in the cluster"
  vpc_id      = data.aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group_rule" "workers_ingress_self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = aws_security_group.worker.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "workers-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 0
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = aws_security_group.eks.id
  to_port                  = 65535
  type                     = "ingress"
}