data "aws_s3_bucket" "ih_datorama_bucket" {
  bucket = "ih-datorama-${var.environment}"
}

data "aws_s3_bucket" "ih_transunion_bucket" {
  bucket = "ih-transunion-${var.environment}"
}

resource "aws_datasync_location_s3" "snowflake_s3_data_migration_datasync_source" {
  s3_bucket_arn = data.aws_s3_bucket.snowflake_datalake_bucket.arn
  subdirectory  = "/"
  s3_config {
    bucket_access_role_arn = aws_iam_role.s3_data_migration_datasync_iam_role.arn
  }
}

resource "aws_datasync_location_s3" "snowflake_s3_data_migration_datasync_target" {
  s3_bucket_arn = module.snowfleak_data_migration_backup_bucket.this.arn
  subdirectory  = "/"
  s3_config {
    bucket_access_role_arn = aws_iam_role.s3_data_migration_datasync_iam_role.arn
  }
  depends_on = [module.snowfleak_data_migration_backup_bucket]
}

resource "aws_datasync_location_s3" "datorama_s3_data_migration_datasync_source" {
  s3_bucket_arn = data.aws_s3_bucket.ih_datorama_bucket.arn
  subdirectory  = "/"
  s3_config {
    bucket_access_role_arn = aws_iam_role.s3_data_migration_datasync_iam_role.arn
  }
}

resource "aws_datasync_location_s3" "datorama_s3_data_migration_datasync_target" {
  s3_bucket_arn = module.snowfleak_data_migration_datorama_backup_bucket.this.arn
  subdirectory  = "/"
  s3_config {
    bucket_access_role_arn = aws_iam_role.s3_data_migration_datasync_iam_role.arn
  }
  depends_on = [module.snowfleak_data_migration_datorama_backup_bucket]
}

resource "aws_datasync_location_s3" "transunion_s3_data_migration_datasync_source" {
  s3_bucket_arn = data.aws_s3_bucket.ih_transunion_bucket.arn
  subdirectory  = "/"
  s3_config {
    bucket_access_role_arn = aws_iam_role.s3_data_migration_datasync_iam_role.arn
  }
}

resource "aws_datasync_location_s3" "transunion_s3_data_migration_datasync_target" {
  s3_bucket_arn = module.snowfleak_data_migration_transunion_backup_bucket.this.arn
  subdirectory  = "/"
  s3_config {
    bucket_access_role_arn = aws_iam_role.s3_data_migration_datasync_iam_role.arn
  }
  depends_on = [module.snowfleak_data_migration_transunion_backup_bucket]
}

resource "aws_datasync_task" "snowflake_s3_data_migration_datasync_task" {
  name                     = "snowflake-s3-data-sync-${var.environment}-task"
  destination_location_arn = aws_datasync_location_s3.snowflake_s3_data_migration_datasync_target.arn
  source_location_arn      = aws_datasync_location_s3.snowflake_s3_data_migration_datasync_source.arn

  options {
    bytes_per_second  = -1
    log_level         = "OFF"
    transfer_mode     = "ALL"
    posix_permissions = "NONE"
    uid               = "NONE"
    gid               = "NONE"
    verify_mode       = "ONLY_FILES_TRANSFERRED"
  }
}

resource "aws_datasync_task" "datorama_s3_data_migration_datasync_task" {
  name                     = "datorama-s3-data-sync-${var.environment}-task"
  destination_location_arn = aws_datasync_location_s3.datorama_s3_data_migration_datasync_target.arn
  source_location_arn      = aws_datasync_location_s3.datorama_s3_data_migration_datasync_source.arn

  options {
    bytes_per_second  = -1
    log_level         = "OFF"
    transfer_mode     = "ALL"
    posix_permissions = "NONE"
    uid               = "NONE"
    gid               = "NONE"
    verify_mode       = "ONLY_FILES_TRANSFERRED"
  }
}

resource "aws_datasync_task" "transunion_s3_data_migration_datasync_task" {
  name                     = "transunion-s3-data-sync-${var.environment}-task"
  destination_location_arn = aws_datasync_location_s3.transunion_s3_data_migration_datasync_target.arn
  source_location_arn      = aws_datasync_location_s3.transunion_s3_data_migration_datasync_source.arn

  options {
    bytes_per_second  = -1
    log_level         = "OFF"
    transfer_mode     = "ALL"
    posix_permissions = "NONE"
    uid               = "NONE"
    gid               = "NONE"
    verify_mode       = "ONLY_FILES_TRANSFERRED"
  }
}

resource "aws_datasync_task" "transunion_s3_data_migration_datasync_task_dummy" {
  name                     = "transunion-s3-data-sync-${var.environment}-task-dummy"
  destination_location_arn = aws_datasync_location_s3.transunion_s3_data_migration_datasync_target.arn
  source_location_arn      = aws_datasync_location_s3.transunion_s3_data_migration_datasync_source.arn
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.datasync_task_cw_log_group.arn

  options {
    bytes_per_second  = -1
    log_level         = "TRANSFER"
    transfer_mode     = "ALL"
    posix_permissions = "NONE"
    uid               = "NONE"
    gid               = "NONE"
    verify_mode       = "ONLY_FILES_TRANSFERRED"
  }
}
