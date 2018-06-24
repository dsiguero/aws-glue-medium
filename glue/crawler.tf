resource "aws_glue_crawler" "s3-crawler" {
  name          = "medium-ingest-s3-crawler"
  database_name = "${aws_glue_catalog_database.ingest.name}"
  role          = "${var.iam_glue_role}"
  schedule      = "cron(15 12 * * ? *)"

  schema_change_policy {
    delete_behavior = "DEPRECATE_IN_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  s3_target {
    path = "${var.s3_origin_path}"
  }
}
