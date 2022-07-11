resource "helm_release" "cluster-autoscaler-controller" {
  name = "cluster-autoscaler-controller"

  repository = "https://nomer26.github.io/Charts/charts/stable"
  chart = "cluster-autoscaler"
  namespace = "kube-system"

  values = [
    "${file("autoscaling_values.yaml")}"
  ]

  set {
    name = "clusterName"
    value = aws_eks_cluster.eks.id
  }

  set {
    name = "annotations.rolearn"
    value = aws_iam_role.eks_cluster_autoscaler.arn
  }

  depends_on = [
    aws_eks_node_group.nodes_general,
    aws_iam_role_policy_attachment.eks_cluster_autoscaler_attach
  ]
}
