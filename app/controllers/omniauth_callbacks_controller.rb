class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def all 
        # raise request.env["omniauth.auth"].to_yaml
        # render json: request.env['omniauth.auth'] 
        user = User.from_omniauth(request.env["omniauth.auth"])
        if user.persisted?
            flash.notice = "Welcome! You are successfully logged in! "
            sign_in_and_redirect user
        else
            redirect_to new_user_registration_url
        end
    end

    alias_method :google_oauth2, :all
    alias_method :facebook, :all
end