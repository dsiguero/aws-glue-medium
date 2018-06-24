module "prerequisites-glue" {
  source = "./prerequisites"

  environment                 = "${var.environment}"
  aws_glue_source_bucket_name = "aws-glue-medium-post"
}

module "glue" {
  source     = "./glue"

  iam_glue_role = "${module.prerequisites-glue.iam_glue_role_arn}"
}

