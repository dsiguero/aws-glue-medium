resource "aws_s3_bucket" "aws-glue-temp-bucket" {
  bucket = "glue-ingest-temp-${var.environment}"
  acl    = "private"

  tags {
    Name        = "Glue Ingest Temporary"
    Environment = "${var.environment}"
  }
}

data "aws_iam_policy_document" "glue-s3-temp-policydoc" {
  statement {
    effect = "Allow"

    actions = [
      "s3:Put*",
      "s3:Get*",
    ]

    resources = [
      "${aws_s3_bucket.aws-glue-temp-bucket.arn}",
      "${aws_s3_bucket.aws-glue-temp-bucket.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "glue-s3-temp-policy" {
  name   = "aws-glue-temp-bucket-policy-${var.environment}"
  path   = "/"
  policy = "${data.aws_iam_policy_document.glue-s3-temp-policydoc.json}"
}

resource "aws_iam_role_policy_attachment" "s3-temp-policy-attachment" {
  role       = "${aws_iam_role.aws-glue-role.name}"
  policy_arn = "${aws_iam_policy.glue-s3-temp-policy.arn}"
}
