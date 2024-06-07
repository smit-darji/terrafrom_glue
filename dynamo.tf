#tfsec:ignore: aws-dynamodb-table-customer-key
resource "aws_dynamodb_table" "ari_api_config" {
  name           = "ari-api-config"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "pk"
  range_key      = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  ttl {
    attribute_name = ""
    enabled        = false
  }

  tags = {
    Name        = "dynamodb-table-ari-api-config"
    Environment = var.environment
  }

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = true
  }
}

#tfsec:ignore: aws-dynamodb-table-customer-key
resource "aws_dynamodb_table" "dynamodb_table_ingestion_run_stats" {
  name         = "sdlf_invh_ingestion_run_stats"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"
  range_key    = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }
}

#tfsec:ignore: aws-dynamodb-table-customer-key
resource "aws_dynamodb_table" "dynamodb_table_ingestion_config_store" {
  name         = "sdlf_invh_ingestion_config_store"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"
  range_key    = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }
}
#tfsec:ignore: aws-dynamodb-table-customer-key
resource "aws_dynamodb_table" "dynamodb_table_curation_mapping_store" {
  name         = "sdlf_invh_curation_mapping_store"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"
  range_key    = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }
}

#tfsec:ignore: aws-dynamodb-table-customer-key
resource "aws_dynamodb_table" "dynamodb_table_curation_sql_for_snowflake" {
  name         = "sdlf_invh_curation_sql_for_snowflake"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"
  range_key    = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }
}

resource "aws_dynamodb_table" "dynamodb_table_budget_planning" {
  name         = "budget_planning"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ID"

  attribute {
    name = "ID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }
}
