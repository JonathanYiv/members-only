class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username].downcase)
    if @user && @user.authenticate(params[:session][:password])
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      log_in @user
      flash[:success] = "Logged in as #{@user.username}"
      redirect_to root_url
    else
      flash[:danger] = "Invalid username and password combination."
      render 'new'
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    forget(@user) if @user

    session.delete(:user_id)
    flash[:success] = "Logged out."
    redirect_to root_url
  end
end
