class SessionsController < Devise::SessionsController
  def create
    super do |user|
      if user.persisted?
        flash[:notice] = "Welcome back, #{user.name}! You have successfully signed in."
      end
    end
  end

  def destroy
    super do |user|
      flash[:notice] = "You have successfully signed out."
    end
  end
end 