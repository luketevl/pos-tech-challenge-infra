
module "aws_cognito_user_pool_restaurante" {

  source                   = "lgallard/cognito-user-pool/aws"
  user_pool_name           = "userpool_restaurante"
  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]

  admin_create_user_config = {
    email_message = "Dear {username}, your verification code is {####}."
    email_subject = "Here, your verification code baby"
    sms_message   = "Your username is {username} and temporary password is {####}."
  }


  # lambda_config = {
  #   pre_sign_up = "arn:aws:lambda:us-east-1:123456789012:function:pre_sign_up"

  # }

  password_policy = {
    minimum_length    = 10
    require_lowercase = false
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
    temporary_password_validity_days = 120
  }

  string_schemas = [
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = false
      name                     = "email"
      required                 = false

      string_attribute_constraints = {
        min_length = 7
        max_length = 15
      }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "document"
      required                 = false

      string_attribute_constraints = {
        min_length = 1
        max_length = 256
      }
    }
  ]
  domain = "restaurante-postech"

  clients = [
  
    {
      allowed_oauth_flows                  = ["code", "implicit"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["email", "openid"]
      callback_urls                        = ["https://localhost:3000/callback"]
      default_redirect_uri                 = "https://localhost:3000/callback"
      explicit_auth_flows                  = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
      generate_secret                      = false
      logout_urls                          = ["https://localhost:000/logout"]
      name                                 = "appclient"
      read_attributes                      = ["email"]
      supported_identity_providers         = ["COGNITO"]
      write_attributes                     = ["email"]
      refresh_token_validity               = 30
    }
  ]

  tags = local.common_tags
}