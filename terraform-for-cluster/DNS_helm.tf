resource "helm_release" "external-dns-controller" {
  name = "external-dns-controller"

  repository = "https://playdatadevx.github.io/dp-platform/Charts/external_dns/stable"
  chart = "externalDNS"
  namespace = "kube-system"

  set {
    name = "serviceaccount.annotation.rolearn"
    value = aws_iam_role.external_dns.arn
  }
  
  depends_on = [
    aws_eks_node_group.nodes_general,
    aws_iam_role_policy.external_dns
  ]
}
