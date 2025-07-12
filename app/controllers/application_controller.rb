class ApplicationController < ActionController::Base
    include Pagy::Backend

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_global_search_variable

    def set_global_search_variable
        @browse = Room.all.ransack(params[:q])
        @pagy_search, @browse_result = pagy(@browse.result(distinct: true), items: 9)
        
        # Set location with better fallback handling
        @location_received = get_user_location

        respond_to do |format|
            format.html
            format.json {
                render json: {
                entries: render_to_string(partial: @browse_result, formats: [:html]), pagination: view_context.pagy_nav(@pagy_search)
                }
            }
        end
    end

    protected

    def get_user_location
        # Privacy-conscious location detection
        Rails.logger.info "Request IP: #{request.remote_ip}"
        
        # Check if user has consented to location sharing
        if session[:location_consent] == true
            Rails.logger.info "User has consented to location sharing"
            
            if request.location.present? && request.location.city.present?
                Rails.logger.info "Location detected: #{request.location.city}"
                return request.location.city
            end
        end
        
        # For development testing
        if Rails.env.development? && ENV['TEST_LOCATION'].present?
            Rails.logger.info "Using test location from ENV: #{ENV['TEST_LOCATION']}"
            return ENV['TEST_LOCATION']
        end
        
        # Default fallback - no location tracking
        Rails.logger.info "Using default location: NYC"
        "NYC"
    end

    def configure_permitted_parameters 
        devise_parameter_sanitizer.permit :sign_up, keys: [:name, :avatar] 
        devise_parameter_sanitizer.permit :account_update, keys: [:name, :avatar, :phone_number, :description, :email, :password]
    end

end
