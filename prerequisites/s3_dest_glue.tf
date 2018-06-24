resource "aws_s3_bucket" "aws-glue-destination-bucket" {
  bucket = "glue-ingest-destination-${var.environment}"
  acl    = "private"

  tags {
    Name        = "Glue Ingest Destination"
    Environment = "${var.environment}"
  }
}

data "aws_iam_policy_document" "glue-s3-destination-policydoc" {
  statement {
    effect = "Allow"

    actions = [
      "s3:Put*",
      "s3:Get*",
    ]

    resources = [
      "${aws_s3_bucket.aws-glue-destination-bucket.arn}",
      "${aws_s3_bucket.aws-glue-destination-bucket.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "glue-s3-destination-policy" {
  name   = "aws-glue-destination-bucket-policy-${var.environment}"
  path   = "/"
  policy = "${data.aws_iam_policy_document.glue-s3-destination-policydoc.json}"
}

resource "aws_iam_role_policy_attachment" "s3-destination-policy-attachment" {
  role       = "${aws_iam_role.aws-glue-role.name}"
  policy_arn = "${aws_iam_policy.glue-s3-destination-policy.arn}"
}
