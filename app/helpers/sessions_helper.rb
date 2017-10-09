module SessionsHelper
  def logged_in?
    !!session[:user_id]
  end

  def log_in user
    session[:user_id] = user.id
  end
end
