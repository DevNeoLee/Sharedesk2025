class UsersController < ApplicationController 
    def show 
        # Don't process non-numeric IDs
        unless params[:id].match?(/\A\d+\z/)
          redirect_to root_path, alert: "Invalid user ID"
          return
        end
        
        @user = User.find(params[:id])
        @rooms = @user.rooms
        @pagy, @rooms_result = pagy(@rooms, items: 10)
    end 
end