class PagesController < ApplicationController
  skip_before_action :set_global_search_variable, only: [:location_consent, :current_user_location]
  
  def home
    @pagy, @rooms = pagy(Room.all, items: 3)
    @search = Room.ransack(params[:q])  # Use all rooms for search, not just paginated ones
    @reviews = Review.all
    @best_reviews = @reviews.order(created_at: :desc).limit(4) # Latest 4 reviews by date
    # @best_rooms = Room.limit(3).order(created_at: :desc) # Latest 3 rooms
    @best_rooms = Room.left_joins(:reviews)
                      .group('rooms.id')
                      .order('AVG(reviews.star) DESC NULLS LAST')
                      .limit(3)
    
    # Set location_received to a city that actually has rooms
    @location_received ||= Rails.env.development? ? "NYC" : "NYC"
    
    # Debug location_received variable
    Rails.logger.info "Location received: #{@location_received.inspect}"
    Rails.logger.info "Location received class: #{@location_received.class}"
    
    # Log flash messages for debugging
    if flash[:notice]
      Rails.logger.info "Flash notice in home: #{flash[:notice]}"
    end
    if flash[:alert]
      Rails.logger.info "Flash alert in home: #{flash[:alert]}"
    end
  end

  def attribution
  end
  
  def search
    @search = Room.ransack(params[:q])
    @pagy, @rooms_result = pagy(@search.result(distinct: true), items: 9)
    
    # Set total count for search results display
    @total_count = @search.result(distinct: true).count
    @browse_result = @rooms_result
    
    respond_to do |format|
      format.html
      format.json {
        render json: {
          entries: render_to_string(partial: @rooms_result, formats: [:html]), 
          pagination: view_context.pagy_nav(@pagy)
        }
      }
    end
  end
  
  def location_consent
    Rails.logger.info "=== Location Consent Request ==="
    Rails.logger.info "Request method: #{request.method}"
    Rails.logger.info "Request params: #{params.inspect}"
    Rails.logger.info "Raw params: #{request.raw_post}" if request.raw_post.present?
    Rails.logger.info "Current session consent: #{session[:location_consent]}"
    Rails.logger.info "Request IP: #{request.remote_ip}"
    
    # Parse JSON body if present
    if request.content_type&.include?('application/json')
      begin
        json_params = JSON.parse(request.raw_post)
        Rails.logger.info "Parsed JSON params: #{json_params.inspect}"
        consent_value = json_params['consent']
      rescue JSON::ParserError => e
        Rails.logger.error "JSON parsing error: #{e.message}"
        consent_value = params[:consent]
      end
    else
      consent_value = params[:consent]
    end
    
    Rails.logger.info "Final consent value: #{consent_value}"
    Rails.logger.info "Consent value class: #{consent_value.class}"
    
    if consent_value == true || consent_value == 'true'
      session[:location_consent] = true
      Rails.logger.info "Location consent granted - session updated"
      render json: { success: true, message: 'Location consent granted' }
    else
      session[:location_consent] = false
      Rails.logger.info "Location consent declined - session updated"
      render json: { success: true, message: 'Location consent declined' }
    end
    
    Rails.logger.info "Final session consent: #{session[:location_consent]}"
  end
  
  def current_user_location
    Rails.logger.info "=== Current User Location Request ==="
    Rails.logger.info "Session consent: #{session[:location_consent]}"
    Rails.logger.info "Session consent class: #{session[:location_consent].class}"
    Rails.logger.info "Session keys: #{session.keys}"
    Rails.logger.info "Request IP: #{request.remote_ip}"
    
    location = get_user_location
    Rails.logger.info "Final location returned: #{location}"
    
    render json: { location: location }
  end
end
