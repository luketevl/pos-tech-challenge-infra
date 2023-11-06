
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

  lambda_config = {
    pre_sign_up = "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:autoConfirm" 
  }

  password_policy = {
    minimum_length    = 10
    require_lowercase = false
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
    temporary_password_validity_days = 120
  }

  domain = "restaurante-postech"

  clients = [
  
    {
      allowed_oauth_flows                  = ["code", "implicit"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["email", "openid"]
      callback_urls                        = ["https://localhost:3000/callback"]
      default_redirect_uri                 = "https://localhost:3000/callback"
      explicit_auth_flows                  = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
      generate_secret                      = true 
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