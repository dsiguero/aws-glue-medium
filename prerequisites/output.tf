output "s3_scripts" {
  value = "${aws_s3_bucket.aws-glue-scripts-bucket.id}"
}

output "s3_destination" {
  value = "${aws_s3_bucket.aws-glue-destination-bucket.id}"
}

output "s3_temp" {
  value = "${aws_s3_bucket.aws-glue-temp-bucket.id}"
}

output "iam_glue_role_arn" {
  value = "${aws_iam_role.aws-glue-role.arn}"
}
