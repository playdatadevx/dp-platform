data "aws_iam_policy_document" "external_dns" {
  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "external_dns" {
  name = "${local.cluster_name}-external-dns-role"

  assume_role_policy = templatefile(
    "${path.module}/policies/oidc_assume_role_policy.json",
    {
      OIDC_ARN = aws_iam_openid_connect_provider.eks.arn,
      OIDC_URL = replace(aws_iam_openid_connect_provider.eks.url,"https://",""),
      NAMESPACE = "kube-system",
    SA_NAME = "external-dns" }
  )

  tags = {
    "ServiceAccountName" = "external-dns"
    "ServiceAccountNameSpace" = "kube-system"
  }
  depends_on = [aws_iam_openid_connect_provider.eks]
}

resource "aws_iam_role_policy" "external_dns" {
  name = "${local.cluster_name}-external-dns-policy"
  role = aws_iam_role.external_dns.id
  policy = data.aws_iam_policy_document.external_dns.json
}
