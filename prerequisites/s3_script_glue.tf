resource "aws_s3_bucket" "aws-glue-scripts-bucket" {
  bucket = "glue-ingest-scripts-${var.environment}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags {
    Name        = "Glue Scripts"
    Environment = "${var.environment}"
  }
}

data "aws_iam_policy_document" "glue-s3-scripts-policydoc" {
  statement {
    effect = "Allow"

    actions = [
      "s3:Put*",
      "s3:Get*",
    ]

    resources = [
      "${aws_s3_bucket.aws-glue-scripts-bucket.arn}",
      "${aws_s3_bucket.aws-glue-scripts-bucket.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "glue-s3-scripts-policy" {
  name   = "aws-glue-scripts-bucket-policy-${var.environment}"
  path   = "/"
  policy = "${data.aws_iam_policy_document.glue-s3-scripts-policydoc.json}"
}

resource "aws_iam_role_policy_attachment" "s3-scripts-policy-attachment" {
  role       = "${aws_iam_role.aws-glue-role.name}"
  policy_arn = "${aws_iam_policy.glue-s3-scripts-policy.arn}"
}
