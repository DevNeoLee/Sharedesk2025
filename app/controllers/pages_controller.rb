class PagesController < ApplicationController
  def home
    @pagy, @rooms = pagy(Room.all, items: 3)
    @search = @rooms.ransack(params[:q])
    @reviews = Review.all
    @best_reviews = @reviews.order(created_at: :desc).limit(4) # Latest 4 reviews by date
    @best_rooms = Room.limit(3).order(created_at: :desc) # Latest 3 rooms
    
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
    # Basic search logic is handled in ApplicationController's set_global_search_variable
    # Additional search logic can be implemented here
    
    # Date-based filtering (future implementation)
    if params[:start_date].present? && params[:end_date].present?
      begin
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        
        # Filter rooms with reservations in the date range
        @browse = @browse.result.joins(:reservations).where.not(
          reservations: {
            start_date: start_date..end_date,
            end_date: start_date..end_date
          }
        ).distinct
      rescue Date::Error
        # Use default search results on date parsing error
      end
    end
    
    # Handle when no search results found - only show message if there's a search query
    if params[:q].present? && @browse_result.empty?
      flash.now[:notice] = "No search results found for #{params[:q]['address_cont']}. Try searching for NYC, Bangkok, or Kolkata."
    end
  end
end
