locals {
  glue_job_iam_role_name    = "datalake-glue-access-role"
  max_retries               = 0
  glue_version              = "3.0"
  python_shell_glue_version = "1.0"
  worker_type               = "G.1X"
  glue_job_start_time       = "1900-01-01 20:24:54.893"
  glue_job_end_time         = "2025-01-01 20:24:54.893"
}

data "aws_iam_role" "glue_job_role" {
  name = local.glue_job_iam_role_name
}

resource "aws_glue_job" "datalake_yardi_property" {
  name              = "datalake-yardi-property-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 15
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-property.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_unit" {
  name              = "datalake-yardi-unit-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 15
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-unit.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_unittype" {
  name              = "datalake-yardi-unittype-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 30
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-unittype.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_tenant" {
  name              = "datalake-yardi-tenant-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-tenant.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_prospect" {
  name              = "datalake-yardi-prospect-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 150
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-prospect.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_tenant_history" {
  name              = "datalake-yardi-tenant-history-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 80
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-tenant-history.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_chargtyp" {
  name              = "datalake-yardi-chargtyp-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 30
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-chargtyp.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "geotab_trip_address" {
  name              = "datalake-geotab-trip-address-${var.environment}-invh"
  description       = "Load geotab trip address data to s3"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  max_retries       = local.max_retries
  timeout           = 120
  worker_type       = local.worker_type
  glue_version      = local.glue_version
  number_of_workers = 2
  connections       = [aws_glue_connection.dna_data_governance_glue_connection.name]

  command {
    name            = "glueetl"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/geotab/geotab-trip-address.py"
    python_version  = "3"
  }

  default_arguments = {
    "--job-language"              = "python"
    "--spark-event-logs-path"     = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/"
    "--enable-glue-datacatalog"   = "true"
    "--extra-py-files"            = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py"
    "--DAG_ID"                    = "get value from airflow",
    "--TASK_ID"                   = "get value from airflow",
    "--additional-python-modules" = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

# new glue jobs

resource "aws_glue_job" "datalake_yardi_accttreexref" {
  name              = "datalake-yardi-accttreexref-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 10
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-accttreexref.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}


resource "aws_glue_job" "datalake_yardi_acct" {
  name              = "datalake-yardi-acct-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 15
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-acct.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}


resource "aws_glue_job" "datalake_yardi_label" {
  name              = "datalake-yardi-label-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 25
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-label.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}


resource "aws_glue_job" "datalake_yardi_fund_data" {
  name              = "datalake-yardi-fund-data-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 25
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-fund-data.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}


resource "aws_glue_job" "datalake_yardi_prospect_history" {
  name              = "datalake-yardi-prospect-history-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-prospect-history.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}


resource "aws_glue_job" "datalake_yardi_propattributes" {
  name              = "datalake-yardi-propattributes-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 10
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-propattributes.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}



resource "aws_glue_job" "datalake_yardi_books" {
  name              = "datalake-yardi-books-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 10
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-books.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}


resource "aws_glue_job" "datalake_yardi_accttreedetail" {
  name              = "datalake-yardi-accttreedetail-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 10
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-accttreedetail.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_camrule" {
  name              = "datalake-yardi-camrule-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 100
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-camrule.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}


resource "aws_glue_job" "datalake_yardi_achdata" {
  name              = "datalake-yardi-achdata-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 30
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-achdata.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}


resource "aws_glue_job" "datalake_yardi_lease_history" {
  name              = "datalake-yardi-lease-history-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-lease-history.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

# snowflake s3 data migration glue job
resource "aws_glue_job" "snowflake_s3_data_migration_glue_job" {
  name         = "snowflake-s3-data-deletion-${var.environment}-invh"
  role_arn     = aws_iam_role.snowflake_s3_data_migration_glue_iam_role.arn
  glue_version = local.python_shell_glue_version
  max_retries  = local.max_retries
  timeout      = 2880
  max_capacity = 1

  command {
    name            = "pythonshell"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/snowflake_migration/snowflake-s3-bucket-data-deletion.py"
  }

  default_arguments = {
    "--SOURCE_BUCKET_NAME" : "snowflake-datalake-${var.environment}-invh",
    "--TempDir" : "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class" : "GlueApp",
    "--enable-glue-datacatalog" : "true",
    "--job-language" : "python",
    "--prebuilt-library-option" : "prebuilt-library-enable"
  }

  execution_property {
    max_concurrent_runs = 3
  }
}


resource "aws_glue_job" "datalake_yardi_unit_status" {
  name              = "datalake-yardi-unit-status-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 50
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-unit-status.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_listprop2" {
  name              = "datalake-yardi-listprop2-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 50
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-listprop2.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_tenstatus" {
  name              = "datalake-yardi-tenstatus-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 35
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-tenstatus.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "geotab_rule_api" {
  name         = "datalake-geotab-rule-api-${var.environment}-invh"
  description  = "datalake-geotab"
  role_arn     = data.aws_iam_role.glue_job_role.arn
  max_retries  = local.max_retries
  timeout      = 2880
  glue_version = "0.9"
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "pythonshell"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/geotab/geotab-rule.py"
    python_version  = "3"
  }


  default_arguments = {
    "--job-language"            = "python"
    "--spark-event-logs-path"   = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/"
    "--enable-glue-datacatalog" = "true"
    "--extra-py-files"          = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.7.2-py3.8.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/psycopg2-2.9.3-cp36-cp36m-linux_x86_64.whl"
    "--DAG_ID"                  = "get value from airflow",
    "--TASK_ID"                 = "get value from airflow",
    "--version"                 = "get value from airflow",
    "--param_file_name"         = "get value from airflow"

  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_attributename" {
  name              = "datalake-yardi-attributename-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 20
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-attributename.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_attributevalue" {
  name              = "datalake-yardi-attributevalue-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 20
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-attributevalue.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_attributexref" {
  name              = "datalake-yardi-attributexref-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 60
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-attributexref.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_y2ylink" {
  name              = "datalake-yardi-y2ylink-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 180
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-y2ylink.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_camcharg" {
  name              = "datalake-yardi-camcharg-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 180
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-camcharg.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_ari_api_historical" {
  name         = "datalake-ari-api-${var.environment}-invh-historical"
  role_arn     = data.aws_iam_role.glue_job_role.arn
  glue_version = local.python_shell_glue_version
  max_retries  = local.max_retries
  timeout      = 180
  max_capacity = 1
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]
  command {
    name            = "pythonshell"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/ari/ari-fuel-historical.py"
  }
  default_arguments = {
    "--extra-py-files" = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/psycopg2-2.9.3-cp36-cp36m-linux_x86_64.whl"
    "--DAG_ID"         = "",
    "--TASK_ID"        = "rule_glue_job_task",
    "--param_filename" = ""
  }
}


resource "aws_glue_job" "datalake_yardi_room" {
  name              = "datalake-yardi-room-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 60
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-room.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_creditcheckmitsdetail" {
  name              = "datalake-yardi-creditcheckmitsdetail-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 60
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-creditcheckmitsdetail.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_trans" {
  name              = "datalake-yardi-trans-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 10
  timeout           = 300
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-trans.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_gldetail" {
  name              = "datalake-yardi-gldetail-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 10
  timeout           = 300
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-gldetail.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_ari_api" {
  name         = "datalake-ari-api-${var.environment}-invh"
  role_arn     = data.aws_iam_role.glue_job_role.arn
  glue_version = local.python_shell_glue_version
  max_retries  = local.max_retries
  timeout      = 180
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "pythonshell"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/ari/ari_glue_job.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/psycopg2-2.9.3-cp36-cp36m-linux_x86_64.whl,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--param_filename"                   = "get value from airflow",
    "--table_name"                       = "get value from airflow",
    "--extract_id"                       = "get value from airflow"
  }

  execution_property {
    max_concurrent_runs = 2
  }
}

resource "aws_glue_job" "datalake_yardi_person" {
  name              = "datalake-yardi-person-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 30
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-person.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_pmuser" {
  name              = "datalake-yardi-pmuser-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 30
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-pmuser.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_detail" {
  name              = "datalake-yardi-detail-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 300
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-detail.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "sdlf_ingetion_glue_job" {
  name              = "datalake-mls-ingestor-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 3
  timeout           = 500
  worker_type       = local.worker_type
  connections = [
    "dna-data-governance-${var.environment}-invh"
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/mls/mls-dataengg-ingestor.py"
  }

  default_arguments = {
    "--p_mls_extract_id"          = "",
    "--p_run_date_hour"           = "NA",
    "--p_run_date_hour_override"  = "N",
    "--p_table_name"              = "sdlf_invh_ingestion_config_store"
    "--DAG_ID"                    = "get value from airflow",
    "--TASK_ID"                   = "get value from airflow",
    "--additional-python-modules" = "psycopg2-binary==2.9.3",
    "--extra-py-files"            = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py"
  }

  execution_property {
    max_concurrent_runs = 20
  }
}

resource "aws_glue_job" "sdlf_dataengg_curation_sql_generation_glue_job" {
  name              = "datalake-sdlf-curation-sql-generate-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 500
  worker_type       = local.worker_type
  connections = [
    "dna-data-governance-${var.environment}-invh"
  ]
  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/mls/sdlf-dataengg-curation-sql-generate.py"
  }
  default_arguments = {
    "--additional-python-modules" = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3",
    "--class"                     = "GlueApp",
    "--p_curation_config_table"   = "sdlf_invh_curation_mapping_store",
    "--p_extract_id"              = "mctds"
  }
}

resource "aws_glue_job" "sdlf_dataengg_transformation_schema_changes_glue_job" {
  name              = "datalake-sdlf-transformation-schema-changes-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 500
  worker_type       = local.worker_type
  connections = [
    "dna-data-governance-${var.environment}-invh"
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/mls/sdlf-dataengg-transformation-schema-changes.py"
  }

  default_arguments = {
    "--Data_set"                  = "gets from airflow",
    "--additional-python-modules" = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3",
    "--class"                     = "GlueApp"
  }
  execution_property {
    max_concurrent_runs = 20
  }
}

resource "aws_glue_job" "datalake_yardi_interfacescreenxml" {
  name              = "datalake-yardi-interfacescreenxml-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 15
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-interfacescreenxml.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "sdlf_mls_dynamodb_put_utility_glue_job" {
  name              = "datalake-mls-dynamodb-put-utility-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 3
  timeout           = 2880
  worker_type       = local.worker_type
  connections = [
    "dna-data-governance-${var.environment}-invh"
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/mls-utility-job/mls-dataengg-dynamodb-put-utility.py"
  }

  default_arguments = {
    "--p_dynamo_table_name"       = "from DAG",
    "--p_fq_data_file"            = "from DAG",
    "--additional-python-modules" = "awswrangler==2.4.0,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 5
  }
}

resource "aws_glue_job" "datalake_yardi_personpet" {
  name              = "datalake-yardi-person-pet-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 30
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-person-pet.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_tenantaging" {
  name              = "datalake-yardi-tenantaging-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-tenantaging.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_accttree" {
  name              = "datalake-yardi-accttree-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-accttree.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_addr" {
  name              = "datalake-yardi-addr-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-addr.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_agentnames" {
  name              = "datalake-yardi-agentnames-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 120
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-agentnames.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_sms_db_extract" {
  name              = "datalake-sms-db-extract-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 180
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/sms_assist/datalake-sms-db-extract.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3",
    "--dbname"                           = "smsdwih",
    "--fileformat"                       = "SMS_ASSIST_DATA_FORMAT",
    "--append_date_column"               = "get value from airflow",
    "--key_column"                       = "get value from airflow",
    "--loadmode"                         = "get value from airflow",
    "--merge_date_column1"               = "get value from airflow",
    "--merge_date_column2"               = "get value from airflow",
    "--s3filepath"                       = "sms_assist/",
    "--append_date_column"               = "get value from airflow",
    "--tablename"                        = "get value from airflow"
  }

  execution_property {
    max_concurrent_runs = 24
  }
}

resource "aws_glue_job" "datalake_yardi_unitbut_ancillaryservices" {
  name              = "datalake-yardi-unitbut-ancillaryservices-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 30
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-unitbut-ancillaryservices.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_deposit_accounting_ingestion" {
  name              = "datalake-deposit-accounting-ingestion-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 15
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/tableau-output-consolidation/deposit_accounting_ingestion.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_itypes" {
  name              = "datalake-yardi-itypes-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 30
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-itypes.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_qualtrics_survey_responses" {
  name              = "datalake-qualtrics-survey-responses-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 300
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/qualtrics_survey_responses/qualtrics-survey-responses.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_syndication_history" {
  name              = "datalake-syndication-history-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 300
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/syndication_history/datalake-syndication-history.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_taskeasy" {
  name              = "datalake-taskeasy-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 60
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/taskeasy/datalake-taskeasy.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3,paramiko"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_datadog_slo_extraction" {
  name              = "datalake-datadog-slo-extraction-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 60
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/datadog/datadog-slo-extraction.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/datadog_api_client.zip,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--extra-jars"                       = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/datadog-api-client-2.5.0.jar"
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 2
  }
}

resource "aws_glue_job" "datalake_ringcentral" {
  name              = "datalake-ringcentral-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 300
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/ringcentral/ringcentral.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_mostrecent_smstop20_aged" {
  name              = "datalake-mostrecent-smstop20aged-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 15
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/tableau-output-consolidation/mostrecent_smstop20_aged.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }

}

resource "aws_glue_job" "rets_ingestor_glue_job" {
  name              = "datalake-mls-rets-ingestor-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 3
  timeout           = 500
  worker_type       = "G.1X"
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/mls/mls-dataengg-rets-ingestor.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "spark",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--p_mls_extract_id"                 = "get value from airflow",
    "--p_run_date_hour"                  = "get value from airflow",
    "--p_run_date_hour_override"         = "get value from airflow",
    "--p_table_name"                     = "sdlf_invh_ingestion_config_store",
    "--TASK_ID"                          = "get value from airflow",
    "--DAG_ID"                           = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3,rets,simplejson"
  }

  execution_property {
    max_concurrent_runs = 20
  }

}

resource "aws_glue_job" "datalake_yardi_param" {
  name              = "datalake-yardi-param-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 30
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-param.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_chatmeter_ingestion" {
  name              = "datalake-chatmeter-ingestion-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 60
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/chatmeter/chatmeter-ingestion.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 2
  }
}

resource "aws_glue_job" "datalake_yardi_transrcharge" {
  name              = "datalake-yardi-transrcharge-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-transrcharge.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_gldetailhacct" {
  name              = "datalake-yardi-gldetailhacct-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-gldetailhacct.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_transdailyrcharge" {
  name              = "datalake-yardi-transdailyrcharge-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-transdailyrcharge.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_gldetail6m" {
  name              = "datalake-yardi-gldetail6m-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-gldetail6m.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_propbut27" {
  name              = "datalake-yardi-propbut27-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-propbut27.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}
resource "aws_glue_job" "datalake_merged_mostrecent" {
  name              = "datalake-merged-mostrecent-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 15
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/tableau-output-consolidation/merged_mostrecent.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}
resource "aws_glue_job" "datalake_chatmeter_market_listings_ingestion" {
  name              = "datalake-chatmeter-market-listings-ingestion-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 60
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/chatmeter/chatmeter-market-listings-ingestion.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 2
  }
}

resource "aws_glue_job" "datalake_yardi_transpaymenttype" {
  name              = "datalake-yardi-transpaymenttype-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-transpaymenttype.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_ringcentral_analytics" {
  name              = "datalake-ringcentral-analytics-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 120
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/ringcentral/ringcentral_analytics.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3",
    "--param_file_name"                  = "get value from airflow",
    "--time_from"                        = "get value from airflow",
    "--time_to"                          = "get value from airflow"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_checkscan_charges" {
  name              = "datalake-yardi-checkscan-charges-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 100
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-checkscan-charges.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake_connector_python-2.4.6-py3.9.egg,s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "mls_media_metadata_hist_invh" {
  name              = "mls-media-metadata-hist-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 6
  timeout           = 600
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/mls/mls-media-metadata-hist.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3,rets-python,simplejson,snowflake-connector-python"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "mls_media_metadata_daily_invh" {
  name              = "mls-media-metadata-daily-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 6
  timeout           = 600
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/mls/mls-media-metadata-daily.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "psycopg2-binary==2.9.3,rets-python,simplejson,snowflake-connector-python"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}


resource "aws_glue_job" "datalake_qualtrics_distribution_dataload" {
  name              = "datalake-qualtrics-distribution-dataload-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 300
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/qualtrics-distribution/qualtrics-distribution-data-load.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_transreceipt" {
  name              = "datalake-yardi-transreceipt-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 45
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-transreceipt.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_sms_qualtrics_distribution" {
  name              = "datalake-sms-qualtrics-distribution-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 600
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/qualtrics-distribution/datalake-sms-qualtrics-distribution.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_edwprospect" {
  name              = "datalake-yardi-edwprospect-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 150
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-edwprospect.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_edwtenanthistory" {
  name              = "datalake-yardi-edwtenanthistory-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 80
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-edwtenanthistory.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_edwleasehistory" {
  name              = "datalake-yardi-edwleasehistory-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 80
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-edwleasehistory.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_edwcamrule" {
  name              = "datalake-yardi-edwcamrule-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 2
  timeout           = 80
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-edwcamrule.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_edwcamcharg" {
  name              = "datalake-yardi-edwcamcharg-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 5
  timeout           = 80
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-edwcamcharg.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_edwperson" {
  name              = "datalake-yardi-edwperson-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 5
  timeout           = 80
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-edwperson.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}

resource "aws_glue_job" "datalake_yardi_edwtenantaging" {
  name              = "datalake-yardi-edwtenantaging-${var.environment}-invh"
  role_arn          = data.aws_iam_role.glue_job_role.arn
  glue_version      = local.glue_version
  max_retries       = local.max_retries
  number_of_workers = 5
  timeout           = 80
  worker_type       = local.worker_type
  connections = [
    aws_glue_connection.yardi.name,
    aws_glue_connection.snowflake_edw_connection.name,
    aws_glue_connection.dna_data_governance_glue_connection.name
  ]

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/yardi/datalake-yardi-edwtenantaging.py"
  }

  default_arguments = {
    "--TempDir"                          = "s3://datalake-etl-logs-${var.environment}-invh/glue-temp/",
    "--class"                            = "GlueApp",
    "--enable-continuous-cloudwatch-log" = "true",
    "--enable-glue-datacatalog"          = "true",
    "--enable-metrics"                   = "true",
    "--enable-spark-ui"                  = "true",
    "--extra-py-files"                   = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/Glue_Audit.py",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--job-insights-byo-rules"           = "",
    "--job-language"                     = "python",
    "--spark-event-logs-path"            = "s3://datalake-etl-logs-${var.environment}-invh/glue-spark-logs/",
    "--FROM_DATE"                        = local.glue_job_start_time,
    "--TO_DATE"                          = local.glue_job_end_time,
    "--DAG_ID"                           = "get value from airflow",
    "--TASK_ID"                          = "get value from airflow",
    "--additional-python-modules"        = "snowflake-connector-python==2.7.2,psycopg2-binary==2.9.3"
  }

  execution_property {
    max_concurrent_runs = 1
  }
}