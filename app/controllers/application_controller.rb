class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    if session[:user_id]
       User.find(session[:user_id])
    end
  end
  helper_method :current_user

  def log_user_out
    session[:user_id] = nil
  end

  helper_method :log_user_out

  def log_user_in(user)
    session[:user_id] = user
  end

end
