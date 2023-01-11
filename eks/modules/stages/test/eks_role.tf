data "aws_iam_policy_document" "eks_policy" {
  statement {
      actions = [
        "ecr:PutImageTagMutability",
        "ecr:DescribeImageScanFindings",
        "ecr:StartImageScan",
        "ecr:GetLifecyclePolicyPreview",
        "ecr:GetDownloadUrlForLayer",
        "ecr:PutImageScanningConfiguration",
        "ecr:GetAuthorizationToken",
        "ecr:ListTagsForResource",
        "ecr:UploadLayerPart",
        "ecr:ListImages",
        "ecr:PutImage",
        "ecr:UntagResource",
        "ecr:BatchGetImage",
        "ecr:CompleteLayerUpload",
        "ecr:DescribeImages",
        "ecr:TagResource",
        "ecr:DescribeRepositories",
        "ecr:StartLifecyclePolicyPreview",
        "ecr:InitiateLayerUpload",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetRepositoryPolicy",
        "ecr:GetLifecyclePolicy"
      ]
      resources = [
        aws_ecr_repository.repository.arn
      ]
  }
}

resource "aws_iam_policy" "policy_eks" {
  name = join("-", [
  local.stage, var.environment, "eks-policy"])
  policy = data.aws_iam_policy_document.eks_policy.json
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "policy_attachment_eks" {
  policy_arn = aws_iam_policy.policy_eks.arn
  role       = module.eks_cluster_private.eks_role_name
}


