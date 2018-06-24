data "aws_iam_policy_document" "glue-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals = {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "aws-glue-role" {
  name               = "aws-glue-role-${var.environment}"
  path               = "/service-role/"
  assume_role_policy = "${data.aws_iam_policy_document.glue-assume-role-policy.json}"
}
