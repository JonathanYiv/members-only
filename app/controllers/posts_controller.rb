class PostsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :elite_user, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @correct_user = current_user.id == @user.id
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "Your post has been created."
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated."
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post
      @post.destroy
      flash[:success] = "Post deleted."
      redirect_to root_url
    else
      flash[:warning] = "This post does not exist."
      redirect_to root_url
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :content)
    end

    def logged_in_user
      unless logged_in?
        flash[:warning] = "Please login to view this page."
        redirect_to login_path
      end
    end

    def correct_user
      @user = User.find(session[:user_id])
      @post = Post.find(params[:id])
      unless @post.user_id == session[:user_id]
        flash[:danger] = "You are not authorized to do this."
        redirect_to root_path
      end
    end

    def elite_user
      current_user.elite?
    end
end
