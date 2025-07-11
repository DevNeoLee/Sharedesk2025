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
    @browse = Room.ransack(params[:q])
    @pagy_search, @browse_result = pagy(@browse.result(distinct: true), items: 9)
    @total_count = @browse.result(distinct: true).count
    
    # Debug logging
    Rails.logger.info "Search params: #{params.inspect}"
    Rails.logger.info "Search query: #{params[:q].inspect}"
    Rails.logger.info "Initial results count: #{@browse_result.count}"
    
    # Date-based filtering
    if params[:start_date].present? && params[:end_date].present?
      begin
        # Parse dates from dd-mm-yy format
        start_date = Date.strptime(params[:start_date], '%d-%m-%y')
        end_date = Date.strptime(params[:end_date], '%d-%m-%y')
        
        # Find rooms that are available during the requested date range
        # A room is available if it has no reservations that overlap with the requested dates
        # Overlap occurs when: reservation_start <= requested_end AND reservation_end >= requested_start
        conflicting_room_ids = Reservation.where(
          'start_date <= ? AND end_date >= ?',
          end_date, start_date
        ).pluck(:room_id).uniq
        
        # Filter out rooms with conflicting reservations
        @browse_result = @browse_result.where.not(id: conflicting_room_ids)
        
        Rails.logger.info "Date filtering: start_date=#{start_date}, end_date=#{end_date}, conflicting_rooms=#{conflicting_room_ids.count}, available_rooms=#{@browse_result.count}"
        
      rescue Date::Error => e
        Rails.logger.error "Date parsing error: #{e.message}"
        # Use default search results on date parsing error
      end
    end
    
    # Handle when no search results found - only show message if there's a search query
    if params[:q].present? && @browse_result.empty?
      if params[:start_date].present? && params[:end_date].present?
        flash.now[:notice] = "No available rooms found for #{params[:q]['address_cont']} during the selected dates. Try different dates or locations."
      else
        flash.now[:notice] = "No search results found for #{params[:q]['address_cont']}. Try searching for NYC, Bangkok, or Kolkata."
      end
    end
  end
end
