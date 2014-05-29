class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    email = params[:email]
    password = params[:password]
    @user = User.find_by_email(email)

    if @user && @user.authenticate(password)
      log_user_in(@user)
      flash[:notice] = "Welcome back #{@user.email}"
      redirect_to root_path
    else
      flash[:notice] = "Email/password incorrect"
      render :new
    end

  end

  def destroy
    log_user_out
    flash[:notice] = "You have logged out"

    redirect_to root_path
  end

end

