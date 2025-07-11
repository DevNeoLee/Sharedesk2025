class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy, :map_image]
  before_action :authenticate_user!, except: [:show, :map_image]
  
  def index
    @rooms = current_user.rooms
    @pagy, @rooms_result = pagy(@rooms, items: 9)
    
    respond_to do |format|
      format.html
      format.json do
        entries_html = render_to_string(partial: 'room_result', collection: @rooms_result, as: :room)
        pagination_html = render_to_string(partial: 'pagination', locals: { pagy: @pagy })
        
        render json: {
          entries: entries_html,
          pagination: pagination_html
        }
      end
    end
  end

  def show
    @images = @room.images
    # for 'reviews' model only showing the detailed reviews on individual room page
    @booked = Reservation.where("room_id = ? AND user_id = ?", @room.id, current_user.id).present? if current_user
    @reviews = @room.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.validate_image?
      if @room.save 
        redirect_to edit_room_path(@room) , notice: "Saved..."
      else
        redirect_to new_room_path , notice: "At leat one image of the room required!"
      end
    end
  end

  def edit
    unless current_user.id == @room.user.id
      redirect_to root_path, notice: "You don't have permission."
    end
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: "Updated..."
    else
      render :edit 
    end
  end
  
  def destroy
    unless current_user.id == @room.user.id
      redirect_to root_path, notice: "You don't have permission."
    end
    @room.destroy
    redirect_to rooms_path, notice: 'Room was successfully destroyed.' 
  end

  def map_image
    map_url = "https://maps.googleapis.com/maps/api/staticmap?zoom=15&size=700x400&markers=size:small%7Ccolor:red%7C#{@room.latitude},#{@room.longitude}&key=#{ENV['MAPS_API_KEY']}"
    
    begin
      response = Net::HTTP.get_response(URI(map_url))
      if response.is_a?(Net::HTTPSuccess)
        send_data response.body, type: 'image/png', disposition: 'inline'
      else
        # Fallback to a placeholder image or error message
        render plain: 'Map not available', status: :not_found
      end
    rescue => e
      Rails.logger.error "Google Maps API error: #{e.message}"
      render plain: 'Map not available', status: :service_unavailable
    end
  end

  private 
    def set_room 
      @room = Room.find(params[:id])
    end

    def room_params 
      params.require(:room).permit(:space_type, :desk_type, :capacity, :noise_level, :bath_room, :manager_on, :listing_name, :security_level, :summary, :address, :is_wifi, :is_kitchen, :is_air, :is_heating, :is_conference, :is_drinks, :is_parking, :is_printing, :price, :active, :latitude, :longitude, images: [])
    end
end
