class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def all 
        # raise request.env["omniauth.auth"].to_yaml
        # render json: request.env['omniauth.auth'] 
        user = User.from_omniauth(request.env["omniauth.auth"])
        if user.persisted?
            flash[:notice] = "Welcome, #{user.name}! You have successfully signed in with #{request.env['omniauth.auth']['provider'].titleize}."
            Rails.logger.info "OAuth login successful for user: #{user.email}, flash notice set: #{flash[:notice]}"
            sign_in_and_redirect user
        else
            flash[:alert] = "There was a problem signing you in through #{request.env['omniauth.auth']['provider'].titleize}."
            Rails.logger.error "OAuth login failed for provider: #{request.env['omniauth.auth']['provider']}"
            redirect_to new_user_registration_url
        end
    end

    def failure
        redirect_to root_path, alert: "Authentication failed. Please try again."
    end

    alias_method :google_oauth2, :all
    alias_method :facebook, :all
end