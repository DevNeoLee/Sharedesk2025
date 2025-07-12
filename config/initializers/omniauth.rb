# OmniAuth Configuration
OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true

# Force HTTPS in production environment
if Rails.env.production?
  OmniAuth.config.full_host = 'https://sharedesk1.onrender.com'
  Rails.logger.info "OmniAuth full_host set to: #{OmniAuth.config.full_host}"
else
  Rails.logger.info "OmniAuth running in development mode"
end

# Check and log environment variables
Rails.logger.info "Google OAuth2 Client ID: #{ENV['GOOGLE_CLIENT_ID']}"
Rails.logger.info "Google OAuth2 Client Secret: #{ENV['GOOGLE_CLIENT_SECRET']}"
Rails.logger.info "Facebook App ID: #{ENV['FACEBOOK_CLIENT_ID']}"
Rails.logger.info "Facebook App Secret: #{ENV['FACEBOOK_CLIENT_SECRET']}"

# Log error if environment variables are missing
if ENV['GOOGLE_CLIENT_ID'].blank? || ENV['GOOGLE_CLIENT_SECRET'].blank?
  Rails.logger.error "Google OAuth2 environment variables are not set!"
end

if ENV['FACEBOOK_CLIENT_ID'].blank? || ENV['FACEBOOK_CLIENT_SECRET'].blank?
  Rails.logger.error "Facebook OAuth2 environment variables are not set!"
end 