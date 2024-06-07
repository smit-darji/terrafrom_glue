locals {
  salesforce_schema_change_alert_system_ssm_prefix = "/users/salesforce/"
}

data "aws_ssm_parameter" "github_access_token" {
  name = "/apps/ci-cd/github-access-token"
}

data "aws_ssm_parameter" "snf_password" {
  name = "/users/snowflake/account/password"
}

data "aws_ssm_parameter" "snf_account" {
  name = "/users/snowflake/account"
}

data "aws_ssm_parameter" "snf_user" {
  name = "/users/snowflake/account/user"
}

data "aws_ssm_parameter" "anaplan_accesskey" {
  name = "/users/anaplan-${var.environment}/access-key-id"
}

data "aws_ssm_parameter" "anaplan_secretkey" {
  name = "/users/anaplan-${var.environment}/secret-access-key"
}

resource "aws_ssm_parameter" "salesforce_schema_change_alert_system_security_token" {
  name  = "${local.salesforce_schema_change_alert_system_ssm_prefix}security_token"
  type  = "SecureString"
  value = "Will be manaully changed"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "salesforce_schema_change_alert_system_password" {
  name  = "${local.salesforce_schema_change_alert_system_ssm_prefix}password"
  type  = "SecureString"
  value = "Will be manaully changed"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "salesforce_schema_change_alert_system_domain" {
  name  = "${local.salesforce_schema_change_alert_system_ssm_prefix}domain"
  type  = "SecureString"
  value = "Will be manaully changed"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "salesforce_schema_change_alert_system_username" {
  name  = "${local.salesforce_schema_change_alert_system_ssm_prefix}username"
  type  = "SecureString"
  value = "Will be manaully changed"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "yardi" {
  name  = "/apps/yardi/db/password"
  type  = "SecureString"
  value = "Will be manaully changed"

  lifecycle {
    ignore_changes = [value]
  }
}

# Data Governance

data "aws_ssm_parameter" "dna_data_governance_password" {
  name = "/users/governance_rds/password"
}

data "aws_ssm_parameter" "dna_data_governance_endpoint" {
  name = "/users/governance_rds/endpoint"
}

data "aws_ssm_parameter" "dna_data_governance_user" {
  name = "/users/governance_rds/user"
}


resource "aws_ssm_parameter" "ari_username" {
  name  = "/users/ari/username"
  type  = "String"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "ari_password" {
  name  = "/users/ari/password"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "pointcentral_host" {
  name  = "/pointcentral/host"
  type  = "String"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "pointcentral_user" {
  name  = "/pointcentral/username"
  type  = "String"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "pointcentral_password" {
  name  = "/pointcentral/password"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "ingestor_bridgeoutput_auth_ssm_parameter" {
  name  = "/mls/ingest/bridgeoutput/authn"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

# Capital Allocation 

data "aws_ssm_parameter" "anaplan_files_img_combined_deployment" {
  name = "/anaplan/files/img_combined_deployment"
}

data "aws_ssm_parameter" "anaplan_files_acquisitions" {
  name = "/anaplan/files/acquisitions"
}

data "aws_ssm_parameter" "anaplan_files_other_acquisitions" {
  name = "/anaplan/files/other_acquisitions"
}

# SMS Assist 

resource "aws_ssm_parameter" "sms_redshift_host" {
  name  = "/sms_assist_redshift/host"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sms_redshift_username" {
  name  = "/sms_assist_redshift/username"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sms_redshift_password" {
  name  = "/sms_assist_redshift/password"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "sms_redshift_port" {
  name  = "/sms_assist_redshift/port"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "taskeasy_host" {
  name  = "/taskeasy/host"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "taskeasy_key" {
  name  = "/taskeasy/key"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "taskeasy_username" {
  name  = "/taskeasy/username"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "datadog_apikeyauth" {
  name  = "/datadog/apikeyauth"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "datadog_appkeyauth" {
  name  = "/datadog/appkeyauth"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "ringcentral_accountid" {
  name  = "/ringcentral/accountId"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "ringcentral_client_id" {
  name  = "/ringcentral/client_id"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "ringcentral_client_secret" {
  name  = "/ringcentral/client_secret"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "ringcentral_extension" {
  name  = "/ringcentral/extension"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "ringcentral_password" {
  name  = "/ringcentral/password"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "ringcentral_username" {
  name  = "/ringcentral/username"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}


resource "aws_ssm_parameter" "rets_username" {
  name  = "/mls/dataengg/retsoutput/authn_username"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "rets_password" {
  name  = "/mls/dataengg/retsoutput/authn_password"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "chatmeter_username" {
  name  = "/chatmeter/username"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "chatmeter_password" {
  name  = "/chatmeter/password"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "gridoutput_authn" {
  name  = "/mls/ingest/dataengg/gridoutput/authn"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "bridgeoutput_authn" {
  name  = "/mls/ingest/dataengg/bridgeoutput/authn"
  type  = "SecureString"
  value = "Will be updated manually"

  lifecycle {
    ignore_changes = [value]
  }
}
