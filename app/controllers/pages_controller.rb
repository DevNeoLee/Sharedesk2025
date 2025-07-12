class PagesController < ApplicationController
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
    Rails.logger.info "Current session consent: #{session[:location_consent]}"
    Rails.logger.info "Request IP: #{request.remote_ip}"
    
    if params[:consent] == 'true'
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
    Rails.logger.info "Request IP: #{request.remote_ip}"
    
    location = get_user_location
    Rails.logger.info "Final location returned: #{location}"
    
    render json: { location: location }
  end
end
