data "aws_iam_role" "glue" {
  name = "datalake-glue-access-role"
}

data "aws_iam_policy" "standard_permission_boundary" {
  name = "standard-permission-boundary"
}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "glue_iam_role_permissions_doc" {
  statement {
    sid     = "SSMReadAccess"
    actions = ["ssm:GetParameter"]
    effect  = "Allow"
    resources = [aws_ssm_parameter.yardi.arn
      , data.aws_ssm_parameter.dna_data_governance_endpoint.arn
      , data.aws_ssm_parameter.dna_data_governance_user.arn
      , data.aws_ssm_parameter.dna_data_governance_password.arn
      , aws_ssm_parameter.ari_username.arn
      , aws_ssm_parameter.ari_password.arn
      , aws_ssm_parameter.sms_redshift_host.arn
      , aws_ssm_parameter.sms_redshift_username.arn
      , aws_ssm_parameter.sms_redshift_password.arn
      , aws_ssm_parameter.sms_redshift_port.arn
      , aws_ssm_parameter.taskeasy_host.arn
      , aws_ssm_parameter.taskeasy_username.arn
      , aws_ssm_parameter.taskeasy_key.arn
      , aws_ssm_parameter.datadog_apikeyauth.arn
      , aws_ssm_parameter.datadog_appkeyauth.arn
      , aws_ssm_parameter.ringcentral_accountid.arn
      , aws_ssm_parameter.ringcentral_client_id.arn
      , aws_ssm_parameter.ringcentral_client_secret.arn
      , aws_ssm_parameter.ringcentral_extension.arn
      , aws_ssm_parameter.ringcentral_password.arn
      , aws_ssm_parameter.ringcentral_username.arn
      , aws_ssm_parameter.chatmeter_username.arn
    , aws_ssm_parameter.chatmeter_password.arn]

  }
  statement {
    sid = "S3ScriptBucketAccess"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:PutObjectTagging",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:ListBucket"
    ]
    effect = "Allow"

    #Wildcard, single role for all dna glue jobs and it need access to all scripts
    resources = [
      "arn:aws:s3:::lambda-functions-${var.environment}-invh/dna-datalake-glue",
      "arn:aws:s3:::lambda-functions-${var.environment}-invh/dna-datalake-glue/*",
      "arn:aws:s3:::datalake-jobs-code-${var.environment}-invh/dna-datalake-glue",
      "arn:aws:s3:::datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/*",
      module.datalake_smsassist_redshift_s3_bucket.this.arn,
      "${module.datalake_smsassist_redshift_s3_bucket.this.arn}/*"
    ]
  }
  statement {
    sid    = "S3DataBucketAccess"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket"
    ]

    #This has to be wildcard as we need to give write access to all objects inside snowflake-datalake s3 bucket object
    resources = [
      "arn:aws:s3:::${data.aws_s3_bucket.snowflake_datalake_bucket.id}",
      "arn:aws:s3:::${data.aws_s3_bucket.snowflake_datalake_bucket.id}/*"
    ]
  }
  statement {
    sid    = "ListAllBuckets"
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets"
    ]
    #LakeFormation permission for S3 Glue crawler to have List bucket access
    resources = [
      "arn:aws:s3:::*"
    ]
  }
  #policy attachment for glue i am role to read dynamo table
  statement {
    sid    = "VisualEditor0"
    effect = "Allow"
    actions = [
      "dynamodb:ListTables"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid    = "VisualEditor3"
    effect = "Allow"
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:PartiQLSelect",
      "dynamodb:PutItem",
      "dynamodb:BatchWriteItem"
    ]
    resources = [
      "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/ari-api-config",
      "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/sdlf_invh_ingestion_run_stats",
      "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/sdlf_invh_curation_sql_store",
      "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/sdlf_invh_curation_sql_for_snowflake",
      "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/sdlf_invh_curation_mapping_store",
      "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/sdlf_invh_alter_table_config_store",
      "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/sdlf_invh_ingestion_config_store"
    ]
  }
}

resource "aws_iam_policy" "glue_iam_role_permissions_policy" {
  name        = "${local.project_common_name}-${var.environment}-policy"
  description = "permissions for parameter store and s3 objects"
  policy      = data.aws_iam_policy_document.glue_iam_role_permissions_doc.json
}

resource "aws_iam_role_policy_attachment" "glue_iam_role_permission_policy_attachment" {
  role       = data.aws_iam_role.glue.id
  policy_arn = aws_iam_policy.glue_iam_role_permissions_policy.arn
}

resource "aws_iam_role_policy_attachment" "glue" {
  role       = data.aws_iam_role.glue.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "snowflake_s3_data_migration_glue_iam_role_permissions_doc" {
  statement {
    sid = "S3ScriptBucketAccess"
    actions = [
      "s3:List*",
      "s3:GetObjectVersion",
      "s3:DeleteObjectVersion",
      "s3:GetObjectAcl",
      "s3:PutObjectAcl",
      "s3:PutObjectVersionAcl",
      "s3:GetBucketLocation",
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging",
      "s3:PutObject"

    ]
    effect = "Allow"

    #Wildcard, single role for all dna glue jobs and it need access to all scripts
    resources = [
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/*",
      "arn:aws:s3:::archived-snowflake-datalake-${var.environment}-invh",
      "arn:aws:s3:::archived-snowflake-datalake-${var.environment}-invh/*",
      "arn:aws:s3:::ih-datorama-${var.environment}",
      "arn:aws:s3:::ih-datorama-${var.environment}/*",
      "arn:aws:s3:::archived-ih-datorama-${var.environment}-invh",
      "arn:aws:s3:::archived-ih-datorama-${var.environment}-invh/*",
      "arn:aws:s3:::ih-transunion-${var.environment}",
      "arn:aws:s3:::ih-transunion-${var.environment}/*",
      "arn:aws:s3:::archived-ih-transunion-${var.environment}-invh",
      "arn:aws:s3:::archived-ih-transunion-${var.environment}-invh/*",
      "arn:aws:s3:::datalake-etl-logs-${var.environment}-invh/*",
      "arn:aws:s3:::datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/*"
    ]
  }
  statement {
    sid    = "AllowPutCloudWatchMetric"
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid    = "AllowPutCloudWatchLogs"
    effect = "Allow"
    actions = [
      "logs:*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "snowflake_s3_data_migration_glue_iam_role_permissions_policy" {
  name        = "snowflake-s3-data-migration-glue-access-${var.environment}-policy"
  description = "permissions for s3 buckets and cloudwatch logs"
  policy      = data.aws_iam_policy_document.snowflake_s3_data_migration_glue_iam_role_permissions_doc.json
}

resource "aws_iam_role" "snowflake_s3_data_migration_glue_iam_role" {
  name               = "snowflake-s3-data-migration-glue-access-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  permissions_boundary = data.aws_iam_policy.standard_permission_boundary.arn
}

resource "aws_iam_role_policy_attachment" "snowflake_s3_data_migration_glue_iam_policy_attachment" {
  role       = aws_iam_role.snowflake_s3_data_migration_glue_iam_role.id
  policy_arn = aws_iam_policy.snowflake_s3_data_migration_glue_iam_role_permissions_policy.arn
}

resource "aws_iam_role_policy_attachment" "aws_glue_servicerole_attachment" {
  role       = aws_iam_role.snowflake_s3_data_migration_glue_iam_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role" "s3_data_migration_datasync_iam_role" {
  name               = "s3-data-migration-datasync-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "datasync.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

  permissions_boundary = data.aws_iam_policy.standard_permission_boundary.arn
}

resource "aws_iam_role_policy_attachment" "s3_data_migration_datasync_iam_policy_attachment" {
  role       = aws_iam_role.s3_data_migration_datasync_iam_role.id
  policy_arn = aws_iam_policy.snowflake_s3_data_migration_glue_iam_role_permissions_policy.arn
}

data "aws_iam_role" "aws_airflow" {
  name = "mwaa-role"
}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "datasync_airflow" {
  statement {
    sid    = "DataSyncExec"
    effect = "Allow"
    actions = [
      "datasync:DescribeTask",
      "datasync:StartTaskExecution",
      "datasync:DescribeTaskExecution"
    ]
    resources = [
      aws_datasync_task.snowflake_s3_data_migration_datasync_task.arn,
      aws_datasync_task.datorama_s3_data_migration_datasync_task.arn,
      aws_datasync_task.transunion_s3_data_migration_datasync_task.arn,
      aws_datasync_task.transunion_s3_data_migration_datasync_task_dummy.arn,
      "${aws_datasync_task.snowflake_s3_data_migration_datasync_task.arn}/execution/*",
      "${aws_datasync_task.datorama_s3_data_migration_datasync_task.arn}/execution/*",
      "${aws_datasync_task.transunion_s3_data_migration_datasync_task.arn}/execution/*",
      "${aws_datasync_task.transunion_s3_data_migration_datasync_task_dummy.arn}/execution/*"
    ]
  }
  statement {
    sid    = "DataSyncRead"
    effect = "Allow"
    actions = [
      "datasync:ListTaskExecutions",
      "datasync:ListTasks"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowPutCloudWatchMetric"
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid    = "AllowPutCloudWatchLogs"
    effect = "Allow"
    actions = [
      "logs:*"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid    = "DynamoDBTableAccess"
    effect = "Allow"
    actions = [
      "dynamodb:PutItem"
    ]
    resources = ["arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/ari-api-config"]
  }

  statement {
    sid = "ReadAccessToS3Objects"
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectRetention",
      "s3:GetObjectTagging",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionTagging",

    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/pointcentralsmarthomes/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/transunion/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/img/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/EDWRawData/*",
      "arn:aws:s3:::datalake-mls-raw-${var.environment}-invh/*",
      "${module.anaplan.this.arn}/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/network-drive/*"
    ]
  }

  statement {
    sid = "ReadAccessToS3Bucket"
    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:GetBucketPublicAccessBlock"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh",
      "arn:aws:s3:::datalake-mls-raw-${var.environment}-invh",
      module.anaplan.this.arn
    ]
  }

  statement {
    sid = "WriteAccessToS3Objects"
    actions = [
      "s3:PutObject"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/img/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/pointcentralsmarthomes/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/transunion/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/EDWRawData/*",
      "${module.anaplan.this.arn}/*"
    ]
  }

  statement {
    sid = "WriteDeletesToS3Objects"
    actions = [
      "s3:PutObjectTagging",
      "s3:DeleteObject"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/pointcentralsmarthomes/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/transunion/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/img/reports/capital_allocation/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/taskeasy/*",
      "arn:aws:s3:::snowflake-datalake-${var.environment}-invh/EDWRawData/*",
      "arn:aws:s3:::datalake-mls-raw-${var.environment}-invh/*",
      "${module.anaplan.this.arn}/*"
    ]
  }

  statement {
    sid     = "ssmRead"
    actions = ["ssm:GetParameter"]
    effect  = "Allow"
    resources = [
      aws_ssm_parameter.pointcentral_host.arn,
      aws_ssm_parameter.pointcentral_user.arn,
      aws_ssm_parameter.pointcentral_password.arn,
      data.aws_ssm_parameter.anaplan_files_img_combined_deployment.arn,
      data.aws_ssm_parameter.anaplan_files_acquisitions.arn,
      data.aws_ssm_parameter.anaplan_files_other_acquisitions.arn,
      data.aws_ssm_parameter.anaplan_accesskey.arn,
      data.aws_ssm_parameter.anaplan_secretkey.arn,
      data.aws_ssm_parameter.github_access_token.arn
    ]
  }
  statement {
    sid = "KMSDecryption"
    actions = ["kms:Decrypt",
    "kms:Describekey"]
    effect    = "Allow"
    resources = ["arn:aws:kms:us-east-1:${data.aws_caller_identity.current.account_id}:key/*"]
    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:PARAMETER_ARN"
      values = [
        "arn:aws:ssm:us-east-1:${data.aws_caller_identity.current.account_id}:parameter/users/anaplan-${var.environment}/secret-access-key"
      ]
    }
  }
}

resource "aws_iam_policy" "datasync_airflow" {
  name        = "datasync-run-${var.environment}-policy"
  description = "permissions for to run datasync task and describe exectuion results"
  policy      = data.aws_iam_policy_document.datasync_airflow.json
}

resource "aws_iam_role_policy_attachment" "aws_airflow" {
  role       = data.aws_iam_role.aws_airflow.id
  policy_arn = aws_iam_policy.datasync_airflow.arn
}

resource "aws_iam_role_policy" "sdlf_curation_transofrmation_dynamo_db_and_bucket_access_policy" {
  name = "sdlf_dataengg_curation_transofrmation_dynamo_db_and_bucket_access_policy"
  role = data.aws_iam_role.glue.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:UpdateItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DescribeTable",
          "dynamodb:BatchGetItem"
        ],
        "Resource" : [
          "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/sdlf_invh_ingestion_config_store",
          "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/sdlf_invh_ingestion_run_stats",
          "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/budget_planning"
        ]
      },
      {
        "Sid" : "DynamodbWrite",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:BatchWriteItem"
        ],
        "Resource" : [
          "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/budget_planning"
        ]
      },
      {
        "Sid" : "S3ScriptBucketAccess",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:PutObjectTagging",
          "s3:DeleteObject",
          "s3:DeleteObjectVersion"
        ],
        "Resource" : [
          "arn:aws:s3:::datalake-mls-raw-${var.environment}-invh",
          "arn:aws:s3:::datalake-mls-raw-${var.environment}-invh/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource" : ["${aws_ssm_parameter.ingestor_bridgeoutput_auth_ssm_parameter.arn}",
          "${aws_ssm_parameter.rets_username.arn}",
          "${aws_ssm_parameter.gridoutput_authn.arn}",
          "${aws_ssm_parameter.bridgeoutput_authn.arn}",
          "${aws_ssm_parameter.rets_password.arn}"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "anaplan_user_policy" {
  name = "anaplan-user-policy"
  policy = jsonencode({
    "Version" : "2012-10-17"
    "Statement" : [
      {
        "Sid" : "S3Access"
        "Effect" : "Allow"
        "Action" : [
          "s3:GetBucketPublicAccessBlock",
          "s3:PutObject",
          "s3:GetObjectAcl",
          "s3:GetObject",
          "s3:GetObjectRetention",
          "s3:GetObjectVersionTagging",
          "s3:ListBucketVersions",
          "s3:GetObjectTagging",
          "s3:ListBucket",
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersion"
        ]
        "Resource" : [
          "${module.anaplan.this.arn}",
          "${module.anaplan.this.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "anaplan_user_policy_attachement" {
  user       = "anaplan-${var.environment}"
  policy_arn = aws_iam_policy.anaplan_user_policy.arn
}