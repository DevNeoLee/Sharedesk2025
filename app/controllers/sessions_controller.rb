class SessionsController < Devise::SessionsController
  def create
    super do |user|
      if user.persisted?
        if user.email == 'demo@email.com'
          flash[:notice] = "Welcome to the demo! You are now logged in as a demo user. Feel free to explore all features."
        else
          flash[:notice] = "Welcome, #{user.name}! You have successfully signed in."
        end
      end
    end
  end

  def destroy
    super do |user|
      flash[:notice] = "You have successfully signed out."
    end
  end
end 