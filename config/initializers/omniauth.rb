# OmniAuth 설정
OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true

# 프로덕션 환경에서 HTTPS 강제
if Rails.env.production?
  OmniAuth.config.full_host = 'https://sharedesk1.onrender.com'
end

# 환경변수 확인 및 로깅
Rails.logger.info "Google OAuth2 Client ID: #{ENV['GOOGLE_CLIENT_ID']}"
Rails.logger.info "Google OAuth2 Client Secret: #{ENV['GOOGLE_CLIENT_SECRET']}"

# 환경변수가 없으면 에러 로그
if ENV['GOOGLE_CLIENT_ID'].blank? || ENV['GOOGLE_CLIENT_SECRET'].blank?
  Rails.logger.error "Google OAuth2 환경변수가 설정되지 않았습니다!"
end 