class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  
  def index
    @rooms = current_user.rooms
        @pagy, @rooms_result = pagy(@rooms, items: 9)
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

  private 
    def set_room 
      @room = Room.find(params[:id])
    end

    def room_params 
      params.require(:room).permit(:space_type, :desk_type, :capacity, :noise_level, :bath_room, :manager_on, :listing_name, :security_level, :summary, :address, :is_wifi, :is_kitchen, :is_air, :is_heating, :is_conference, :is_drinks, :is_parking, :is_printing, :price, :active, :latitude, :longitude, images: [])
    end
end
