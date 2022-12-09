data "aws_iam_policy_document" "ec2_bastion" {
  statement {
    actions = [
      "eks:*",
      "iam:ListRoles"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2_bastion" {
  name   = join("-", [local.stage, var.environment, "bastion-policy"])
  policy = data.aws_iam_policy_document.ec2_bastion.json
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "policy_attachment_1" {
  policy_arn = aws_iam_policy.ec2_bastion.arn
  role       = module.dev_ec2.ec2_role_name
}
