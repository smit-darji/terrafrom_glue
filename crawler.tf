locals {
  glue_db_name                       = "yardi-dbo"
  glue_crawler_name                  = "yardi-dbo-crawler"
  db_connection_tables               = ["acct", "chargtyp", "unit_status", "unittype", "fund_data", "lease_history", "camrule", "camcharg", "gldetail", "room", "prospect", "achdata", "trans", "label", "tenant_history", "prospect_history", "unit", "listprop2", "propattributes", "books", "property", "y2ylink", "total", "accttreedetail", "accttreexref", "tenant", "tenstatus", "attributename", "attributevalue", "attributexref", "creditcheckmitsdetail", "person", "pmuser", "detail", "accttree", "tenantaging", "person_pet", "addr", "agentnames", "unitbut_ancillaryservices", "itypes", "param", "propbut27", "checkscan_charges"]
  snowflake_datalake_schema_dir_name = "salesforce-schema-change-data"
}

data "aws_lakeformation_data_lake_settings" "lake_formation" {
  catalog_id = data.aws_caller_identity.current.account_id
}

resource "aws_lakeformation_data_lake_settings" "lake_formation" {
  admins = data.aws_lakeformation_data_lake_settings.lake_formation.admins
}

resource "aws_glue_catalog_database" "yardi" {
  name = local.glue_db_name
}


resource "aws_lakeformation_permissions" "yardi" {
  principal   = "IAM_ALLOWED_PRINCIPALS"
  permissions = ["ALL"]

  database {
    name       = aws_glue_catalog_database.yardi.name
    catalog_id = data.aws_caller_identity.current.account_id
  }
}

resource "aws_glue_crawler" "yardi_glue_crawler" {
  database_name = aws_glue_catalog_database.yardi.name
  name          = local.glue_crawler_name
  role          = data.aws_iam_role.glue.arn

  schema_change_policy {
    delete_behavior = "DEPRECATE_IN_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  recrawl_policy {
    recrawl_behavior = "CRAWL_EVERYTHING"
  }

  lineage_configuration {
    crawler_lineage_settings = "DISABLE"
  }

  dynamic "jdbc_target" {
    for_each = local.db_connection_tables

    content {
      connection_name = aws_glue_connection.yardi.name
      path            = "${local.yardi_db}/dbo/${jdbc_target.value}"
    }
  }
}
