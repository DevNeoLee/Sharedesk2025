class UsersController < ApplicationController 
    def show 
        @user = User.find(params[:id])
        @rooms = @user.rooms
        @pagy, @rooms_result = pagy(@rooms, items: 10)
    end 
end