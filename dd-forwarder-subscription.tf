data "aws_lambda_function" "datadog_forwarder_function" {
  function_name = "Datadog_Forwarder"
}

resource "aws_cloudwatch_log_subscription_filter" "datadog_forwarder_subscription" {
  name = "forwarder_subscription_filter"
  for_each = toset(["airflow-datalake-${var.environment}-mwaa-DAGProcessing",
    "airflow-datalake-${var.environment}-mwaa-Scheduler",
    "airflow-datalake-${var.environment}-mwaa-Task",
    "airflow-datalake-${var.environment}-mwaa-WebServer",
    "airflow-datalake-${var.environment}-mwaa-Worker",
    "/ecs/img-reports",
    "/aws/rds/cluster/dna-data-governance/postgresql",
    "dms-tasks-dna-replication-instance",
    "/aws-glue/crawlers",
    "/aws-glue/jobs/error",
    "/aws-glue/jobs/logs-v2",
    "/aws-glue/jobs/output",
    "/aws-glue/python-jobs/error",
  "/aws-glue/python-jobs/output"])
  log_group_name  = each.key
  filter_pattern  = ""
  destination_arn = data.aws_lambda_function.datadog_forwarder_function.arn
}
