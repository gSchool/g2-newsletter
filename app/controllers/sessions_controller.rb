class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by_email(email)

    if user.present? && user.authenticate(password)
      session[:user_id] = user.id
      flash[:notice] = "Welcome back #{user.email}"
      redirect_to root_path
    else
      render :new
    end

  end

  def destroy
    session.clear
    flash[:notice] = "You have logged out."

    redirect_to root_path
  end

end

