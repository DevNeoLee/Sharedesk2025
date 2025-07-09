class UsersController < ApplicationController 
    def show 
        # 숫자가 아닌 ID는 처리하지 않음
        unless params[:id].match?(/\A\d+\z/)
          redirect_to root_path, alert: "Invalid user ID"
          return
        end
        
        @user = User.find(params[:id])
        @rooms = @user.rooms
        @pagy, @rooms_result = pagy(@rooms, items: 10)
    end 
end