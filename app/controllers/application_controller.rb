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
        Rails.logger.info "Location consent status: #{session[:location_consent]}"
        
        # Check if user has consented to location sharing
        if session[:location_consent] == true
            Rails.logger.info "User has consented to location sharing"
            
            # Try multiple methods to get user location
            location = nil
            
            # Method 1: Try request.location (Geocoder gem)
            if request.location.present? && request.location.city.present?
                location = request.location.city
                Rails.logger.info "Location detected via request.location: #{location}"
            end
            
            # Method 2: Try direct Geocoder search if Method 1 failed
            if location.blank?
                begin
                    # Get the real client IP (handles proxies)
                    client_ip = get_real_client_ip
                    Rails.logger.info "Attempting Geocoder search for IP: #{client_ip}"
                    
                    # Use Geocoder to get location from IP
                    result = Geocoder.search(client_ip).first
                    if result && result.city.present?
                        location = result.city
                        Rails.logger.info "Geocoder location detected: #{location}"
                    else
                        Rails.logger.warn "Geocoder returned no city for IP: #{client_ip}"
                    end
                rescue => e
                    Rails.logger.error "Error in IP geolocation: #{e.message}"
                    Rails.logger.error "Backtrace: #{e.backtrace.first(3).join(', ')}"
                end
            end
            
            # Method 3: Try alternative IP lookup services if still no location
            if location.blank?
                begin
                    client_ip = get_real_client_ip
                    Rails.logger.info "Trying alternative location service for IP: #{client_ip}"
                    
                    # Try a different approach - use HTTP request to IP geolocation service
                    require 'net/http'
                    require 'json'
                    
                    uri = URI("http://ip-api.com/json/#{client_ip}")
                    response = Net::HTTP.get_response(uri)
                    
                    if response.is_a?(Net::HTTPSuccess)
                        data = JSON.parse(response.body)
                        if data['status'] == 'success' && data['city'].present?
                            location = data['city']
                            Rails.logger.info "Alternative service location detected: #{location}"
                        end
                    end
                rescue => e
                    Rails.logger.error "Error in alternative location service: #{e.message}"
                end
            end
            
            return location if location.present?
        else
            Rails.logger.info "User has not consented to location sharing"
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
    
    private
    
    def get_real_client_ip
        # Get the real client IP address, handling various proxy scenarios
        ip = request.env['HTTP_X_FORWARDED_FOR']&.split(',')&.first&.strip ||
             request.env['HTTP_X_REAL_IP'] ||
             request.env['HTTP_CLIENT_IP'] ||
             request.remote_ip
        
        Rails.logger.info "Real client IP detected: #{ip}"
        ip
    end

    def configure_permitted_parameters 
        devise_parameter_sanitizer.permit :sign_up, keys: [:name, :avatar] 
        devise_parameter_sanitizer.permit :account_update, keys: [:name, :avatar, :phone_number, :description, :email, :password]
    end

end
