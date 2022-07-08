resource "helm_release" "cluster-autoscaler-controller" {
  name = "cluster-autoscaler-controller"

  repository = "https://kubernetes.github.io/autoscaler"
  chart = "cluster-autoscaler"
  namespace = "kube-system"

  set {
    name = "awsRegion"
    value = local.region
  }

  set {
    name = "replicaCount"
    value = "2"
  }

  set { 
    name = "image.tag"
    value = "v1.12.0"
  }

  set {
    name = "autoDiscovery.clusterName"
    value = aws_eks_cluster.eks.id
  }

  set {
    name ="rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }

  set {
    name = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.eks_cluster_autoscaler.arn
  }
  depends_on = [
    aws_eks_node_group.nodes_general,
    aws_iam_role_policy_attachment.eks_cluster_autoscaler_attach
  ]
}
