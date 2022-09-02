data "aws_eks_cluster" "eks_cluster" {
  name = var.eks_cluster_name
}

data "aws_iam_openid_connect_provider" "eks_cluster_oidc" {
  url = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_route53_zone" "private_hosted_zone" {
  name = var.domain

  vpc {
    vpc_id = local.vpc_id
  }
}

resource "aws_iam_role" "external_dns_role" {
  name = "external_dns_role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${local.openid_connect_provider_arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${local.openid_connect_provider_url}:sub" : "system:serviceaccount:${var.namespace}:external-dns"
          }
        }
      }
    ]
  })

  managed_policy_arns = [aws_iam_policy.external_dns_pod_policy.arn]
}

resource "aws_iam_policy" "external_dns_pod_policy" {
  name = "external_dns_pod_policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets"
        ],
        "Resource" : [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "external_dns_role_attachment" {
  role       = aws_iam_role.external_dns_role.name
  policy_arn = aws_iam_policy.external_dns_pod_policy.arn
}

resource "helm_release" "external-dns" {
  chart            = "external-dns"
  name             = "external-dns"
  namespace        = var.namespace
  create_namespace = true
  repository       = "https://kubernetes-sigs.github.io/external-dns/"
  version          = "1.11.0"
  wait             = true


  values = [
    templatefile("${path.module}/templates/external-dns.yaml", {
      external_dns_role_arn = aws_iam_role.external_dns_role.arn
      domain                = var.domain
      node_selector         = var.node_selector
    })
  ]

  depends_on = [aws_route53_zone.private_hosted_zone]
}
