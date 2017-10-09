class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :elite_user, only: [:index]
  before_action :correct_or_elite_user, only: :show

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Account created."
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Information updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      flash[:success] = "Account deleted."
      redirect_to root_path
    else
      flash[:warning] = "This user does not exist."
      redirect_to root_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        flash[:warning] = "Please login to view this page."
        redirect_to login_path
      end
    end

    def correct_user
      @user = User.find(session[:user_id])
      unless params[:id].to_i == session[:user_id]
        flash[:danger] = "You are not authorized to do this."
        redirect_to root_path
      end
    end

    def elite_user
      @user = User.find(session[:user_id])
      unless @user.elite?
        flash[:warning] = "You aren't one of the elite!"
        redirect_to root_path
      end
    end

    def correct_or_elite_user
      @user = User.find_by(id: session[:user_id])
      unless params[:id].to_i == session[:user_id] || @user.elite?
        flash[:danger] = "You are not authorized to see this."
        redirect_to root_path
      end
    end
end
