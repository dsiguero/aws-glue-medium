module "prerequisites-glue" {
  source = "./prerequisites"

  environment                 = "${var.environment}"
  aws_glue_source_bucket_name = "aws-glue-medium-post"
}
