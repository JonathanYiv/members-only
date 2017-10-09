module SessionsHelper
  def logged_in?
     # need to add remembering functionality

    user = User.find_by(id: cookies[:user_id])
    if user
      remembered = user.validate_token(cookies[:remember_token])
      log_in user
    end

    !!session[:user_id] || remembered
  end

  def log_in user
    session[:user_id] = user.id
  end

  def remember user
    remember_token = User.new_token
    user.create_remember_digest(remember_token)
    cookies.permanent[:remember_token] = remember_token
    cookies.permanent[:user_id] = user.id
  end

  def forget user
    user.forget
    cookies.delete(:remember_token)
    cookies.delete(:user_id)
  end
end
