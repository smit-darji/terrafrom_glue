locals {
  warehouse              = "INVH_EDW_SNOWFLAKE"
  yardi_user             = "afzma_live7s_RO"
  yardi_db               = "afzmak_live7s"
  yardi_ip               = "10.185.8.48:1433"
  dna_data_governance_db = "warehouse"


  snf_role = {
    dev  = "SYSADMIN",
    qa   = "SYSADMIN",
    prod = "SYSADMIN"
  }
}

resource "aws_glue_connection" "yardi" {
  name            = "datalake-yardi-${local.yardi_db}-${var.environment}-invh"
  description     = "JDBC connection to Yardi ${local.yardi_db} database"
  connection_type = "JDBC"

  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:sqlserver://${local.yardi_ip};databaseName=${local.yardi_db}",
    PASSWORD            = aws_ssm_parameter.yardi.value,
    USERNAME            = local.yardi_user
  }

  physical_connection_requirements {
    availability_zone      = "us-east-1a"
    security_group_id_list = [data.aws_security_group.glue.id]
    subnet_id              = data.aws_subnet.general_1a.id
  }
}

resource "aws_glue_connection" "snowflake_edw_connector" {
  connection_properties = {
    CONNECTOR_CLASS_NAME = "net.snowflake.client.jdbc.SnowflakeDriver",
    CONNECTOR_TYPE       = "Jdbc",
    CONNECTOR_URL        = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake-jdbc-3.13.9.jar",
    JDBC_CONNECTION_URL  = "[[\"default=jdbc:snowflake://${data.aws_ssm_parameter.snf_account.value}.snowflakecomputing.com/?user=${data.aws_ssm_parameter.snf_user.value}\u0026password=${data.aws_ssm_parameter.snf_password.value}\u0026warehouse=${local.warehouse}&role=${local.snf_role[var.environment]}\"],\"\u0026\"]"
  }

  match_criteria  = ["template-connection"]
  name            = "datalake-snowflake-edw-${var.environment}-invh"
  description     = "Connector to Snowflake INVH_EDW_SNOWFLAKE warehouse"
  connection_type = "CUSTOM"
}

resource "aws_glue_connection" "snowflake_edw_connection" {
  connection_properties = {
    CONNECTOR_CLASS_NAME = "net.snowflake.client.jdbc.SnowflakeDriver",
    CONNECTOR_TYPE       = "Jdbc",
    CONNECTOR_URL        = "s3://datalake-jobs-code-${var.environment}-invh/dna-datalake-glue/modules/snowflake-jdbc-3.13.9.jar",
    JDBC_CONNECTION_URL  = "jdbc:snowflake://${data.aws_ssm_parameter.snf_account.value}.snowflakecomputing.com/?user=${data.aws_ssm_parameter.snf_user.value}\u0026password=${data.aws_ssm_parameter.snf_password.value}\u0026warehouse=${local.warehouse}\u0026role=${local.snf_role[var.environment]}",
    PASSWORD             = data.aws_ssm_parameter.snf_password.value,
    USERNAME             = data.aws_ssm_parameter.snf_user.value
  }

  physical_connection_requirements {
    availability_zone      = "us-east-1a"
    security_group_id_list = [data.aws_security_group.glue.id]
    subnet_id              = data.aws_subnet.general_1a.id
  }

  match_criteria = ["Connection",
  "datalake-snowflake-edw-${var.environment}-invh"]
  name            = "datalake-snowflake-edw-stg-${var.environment}-invh"
  description     = "Connection to Snowflake INVH_EDW_SNOWFLAKE warehouse"
  connection_type = "CUSTOM"
}


# data governance

resource "aws_glue_connection" "dna_data_governance_glue_connection" {
  name            = "dna-data-governance-${var.environment}-invh"
  description     = "JDBC connection to dna data governance ${local.dna_data_governance_db} database"
  connection_type = "JDBC"

  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:postgresql://${data.aws_ssm_parameter.dna_data_governance_endpoint.value};databaseName=${local.dna_data_governance_db}",
    PASSWORD            = data.aws_ssm_parameter.dna_data_governance_password.value,
    USERNAME            = data.aws_ssm_parameter.dna_data_governance_user.value
  }

  physical_connection_requirements {
    availability_zone      = "us-east-1a"
    security_group_id_list = [data.aws_security_group.glue.id]
    subnet_id              = data.aws_subnet.general_1a.id
  }
}




