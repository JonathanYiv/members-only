class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = "Logged in as #{@user.username}"
      redirect_to root_url
    else
      flash[:danger] = "Invalid username and password combination."
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "Logged out."
    redirect_to root_url
  end
end
