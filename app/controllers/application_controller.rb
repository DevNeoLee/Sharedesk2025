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
        # Simple fallback for development
        if request.location.present? && request.location.city.present?
            request.location.city
        else
            "NYC"
        end
    end

    def configure_permitted_parameters 
        devise_parameter_sanitizer.permit :sign_up, keys: [:name, :avatar] 
        devise_parameter_sanitizer.permit :account_update, keys: [:name, :avatar, :phone_number, :description, :email, :password]
    end

end
