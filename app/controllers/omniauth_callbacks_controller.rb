class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def all 
        Rails.logger.info "=== OAuth Callback Request ==="
        Rails.logger.info "Provider: #{request.env['omniauth.auth']['provider']}"
        Rails.logger.info "Auth hash keys: #{request.env['omniauth.auth'].keys}"
        
        begin
            user = User.from_omniauth(request.env["omniauth.auth"])
            Rails.logger.info "User from OAuth: #{user.inspect}"
            
            if user.persisted?
                Rails.logger.info "User persisted successfully"
                flash[:notice] = "Welcome, #{user.name}! You have successfully signed in with #{request.env['omniauth.auth']['provider'].titleize}."
                Rails.logger.info "OAuth login successful for user: #{user.email}, flash notice set: #{flash[:notice]}"
                sign_in_and_redirect user
            else
                Rails.logger.error "User not persisted: #{user.errors.full_messages}"
                flash[:alert] = "There was a problem signing you in through #{request.env['omniauth.auth']['provider'].titleize}."
                Rails.logger.error "OAuth login failed for provider: #{request.env['omniauth.auth']['provider']}"
                redirect_to new_user_registration_url
            end
        rescue => e
            Rails.logger.error "OAuth callback error: #{e.message}"
            Rails.logger.error "Backtrace: #{e.backtrace.first(5).join(', ')}"
            flash[:alert] = "Authentication failed. Please try again."
            redirect_to new_user_registration_url
        end
    end

    def failure
        Rails.logger.error "=== OAuth Failure ==="
        Rails.logger.error "Failure params: #{params.inspect}"
        Rails.logger.error "Failure message: #{params[:message]}"
        redirect_to root_path, alert: "Authentication failed. Please try again."
    end

    alias_method :google_oauth2, :all
    alias_method :facebook, :all
end