class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :log_user_in

  def log_user_in(user)
    session[:user_id] = user.id
    session[:expire_time] = Time.now + (60 * 60 * 24)
  end

  helper_method :current_user

  def current_user
    if logged_in?
      User.find(session[:user_id])
    end
  end

  helper_method :log_user_out

  def log_user_out
    session[:user_id] = nil
    session[:expire_time] = nil
  end

  helper_method :validate_session

  def validate_session
    if logged_in?
      if session[:expire_time] < Time.now
        log_user_out
        flash[:notice] = "Your session has expired"
        redirect_to new_session_path
      end
    end
  end

  helper_method :logged_in?

  def logged_in?
    !!session[:user_id]
  end
end
