resource "aws_iam_role_policy_attachment" "default-policy-attachment" {
  role       = "${aws_iam_role.aws-glue-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}
