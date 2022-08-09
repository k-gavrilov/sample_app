class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to user show page
    else
      # Render error message
      flash.now['danger'] = 'Incorrect email/password combination'
      render 'new'
    end
  end

  def destroy

  end
end
