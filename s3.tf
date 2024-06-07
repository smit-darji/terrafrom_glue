data "aws_s3_bucket" "glue_logs" {
  bucket = "datalake-etl-logs-${var.environment}-invh"
}

data "aws_s3_bucket" "snowflake_datalake_bucket" {
  bucket = "snowflake-datalake-${var.environment}-invh"
}

resource "aws_s3_bucket_object" "glue_spark_logs" {
  bucket = data.aws_s3_bucket.glue_logs.bucket
  acl    = "private"
  key    = "glue-spark-logs/"
}

resource "aws_s3_bucket_object" "glue_temp" {
  bucket = data.aws_s3_bucket.glue_logs.bucket
  acl    = "private"
  key    = "glue-temp/"
}

module "s3_bucket" {
  source  = "app.terraform.io/invitation-homes/s3-bucket-module/aws"
  version = "~> 3.2"

  sensitivity   = "internal"
  bucket_prefix = "datalake-jobs-code"
}

resource "aws_s3_bucket_object" "snowflake_datalake_schema_dir" {
  provider     = aws
  bucket       = data.aws_s3_bucket.snowflake_datalake_bucket.bucket
  acl          = "private"
  key          = "${local.snowflake_datalake_schema_dir_name}/"
  content_type = "application/x-directory"
}

module "snowfleak_data_migration_backup_bucket" {
  source  = "app.terraform.io/invitation-homes/s3-bucket-module/aws"
  version = "~> 3.2"

  sensitivity   = "internal"
  bucket_prefix = "archived-snowflake-datalake"
}

module "snowfleak_data_migration_datorama_backup_bucket" {
  source  = "app.terraform.io/invitation-homes/s3-bucket-module/aws"
  version = "~> 3.2"

  sensitivity   = "internal"
  bucket_prefix = "archived-ih-datorama"
}

module "snowfleak_data_migration_transunion_backup_bucket" {
  source  = "app.terraform.io/invitation-homes/s3-bucket-module/aws"
  version = "~> 3.2"

  sensitivity   = "internal"
  bucket_prefix = "archived-ih-transunion"
}

module "datalake_mls_raw_s3_bucket" {
  source  = "app.terraform.io/invitation-homes/s3-bucket-module/aws"
  version = "~> 3.2"

  sensitivity   = "internal"
  bucket_prefix = "datalake-mls-raw"
}

module "datalake_smsassist_redshift_s3_bucket" {
  source  = "app.terraform.io/invitation-homes/s3-bucket-module/aws"
  version = "~> 3.2"

  sensitivity   = "internal"
  bucket_prefix = "datalake-smsassist-redshift"
}

module "anaplan" {
  source  = "app.terraform.io/invitation-homes/s3-bucket-module/aws"
  version = "~> 3.2"

  sensitivity   = "internal"
  bucket_prefix = "anaplan"
}
