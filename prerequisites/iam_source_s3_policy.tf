data "aws_s3_bucket" "glue-source-bucket" {
  bucket = "${var.aws_glue_source_bucket_name}"
}

data "aws_iam_policy_document" "glue-s3-source-policydoc" {
  statement {
    effect  = "Allow"
    actions = ["s3:Get*"]

    resources = [
      "${data.aws_s3_bucket.glue-source-bucket.arn}",
      "${data.aws_s3_bucket.glue-source-bucket.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "glue-s3-source-policy" {
  name   = "aws-glue-source-bucket-policy-${var.environment}"
  path   = "/"
  policy = "${data.aws_iam_policy_document.glue-s3-source-policydoc.json}"
}

resource "aws_iam_role_policy_attachment" "s3-policy-attachment" {
  role       = "${aws_iam_role.aws-glue-role.name}"
  policy_arn = "${aws_iam_policy.glue-s3-source-policy.arn}"
}
