data "aws_subnet" "general_1a" {
  tags = {
    Name = "${var.environment}-general-private-us-east-1a"
  }
}

data "aws_security_group" "glue" {
  name = "datalake-mwaa-${var.environment}-listener"
}

resource "aws_security_group_rule" "self_allow_traffic" {

  description       = "Allow All Traffic for Self"
  type              = "ingress"
  security_group_id = data.aws_security_group.glue.id
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  self              = true
}
