data "template_file" "policy" {
  template = file("./iam_occm_policy.json")
}

data "aws_iam_policy_document" "assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_policy" "policy" {
  policy = data.template_file.policy.rendered
  name   = var.name
}

resource "aws_iam_role" "role" {
  name                  = var.name
  assume_role_policy    = data.aws_iam_policy_document.assume_policy.json
  force_detach_policies = true
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  policy_arn = aws_iam_policy.policy.arn
  role       = aws_iam_role.role.name
}

resource "aws_iam_instance_profile" "occm" {
  name = var.name
  role = aws_iam_role.role.name
}
