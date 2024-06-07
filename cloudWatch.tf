#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "datasync_task_cw_log_group" {
  name = "/aws/datasync-${var.environment}-logs"
}
