class ReservationsController < ApplicationController 
    before_action :authenticate_user!, except: [:preload, :preview]

    def preload 
        room = Room.find(params[:room_id])
        today = Date.today 
        reservations = room.reservations.where("start_date >= ? OR end_date >= ? ", today, today)

        render json: reservations
    end

    def preview 
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])

        output = {
            conflict: is_conflict(start_date, end_date)
        }

        render json: output
    end

    def create 
        @reservation = current_user.reservations.create(reservation_params)

        redirect_to @reservation.room, notice: "Your reservation has been created!"
    end

    def your_trips 
        @trips = current_user.reservations

        @pagy, @trips_result = pagy(@trips, items: 8)
    end

    def yourlisting_reservations 
        @rooms = current_user.rooms
        @total_reservation = 0
        @total_earning = 0

        @rooms.each do |room| 
            if room.reservations.count > 0 && room.price != nil
                @total_earning += ( room.reservations.count * room.price )     
            end
            @total_reservation += room.reservations.count
        end

        @pagy, @rooms_result = pagy(@rooms, items: 8)
    end

    private 
    
    def is_conflict(start_date, end_date)
        room = Room.find(params[:room_id])

        check = room.reservations.where("? <start_date AND end_date < ?", start_date, end_date)
        check.size > 0? true : false
    end

    def reservation_params 
        params.require(:reservation).permit(:start_date, :end_date, :price, :total, :room_id)
    end
end