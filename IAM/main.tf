resource "aws_iam_user" "IAM" {
  name = "IAM"
  path = "/"

  tags = {
    tag-key = "tag-key"
  }
}

resource "aws_iam_access_key" "IAM" {
  user = aws_iam_user.IAM.name
}

data "aws_iam_policy_document" "IAM_ro" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:connect*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "IAM_ro" {
  name   = "test"
  user   = aws_iam_user.IAM.name
  policy = data.aws_iam_policy_document.IAM_ro.json

}