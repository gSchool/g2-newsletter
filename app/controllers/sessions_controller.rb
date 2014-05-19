class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by_email(email)
    if user.nil?
      render :new
    else
      user.password_digest == password
      session[:user_id] = user.id
      flash[:notice] = "Welcome back"
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end

