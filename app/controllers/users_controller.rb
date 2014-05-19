class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]
    @user = User.new(:email => email, :password => password)

    if password != password_confirmation
      @notice = "Passwords must match"
      render :new
    elsif password.length < 8
      @notice = "Password must be longer than 8 characters"
      render :new
    elsif /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,3}/.match(email).nil?
      @notice = "Must be a valid email address"
     render :new
    elsif @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome"
      redirect_to root_path
    else
      render :new
    end
  end

  def logout
    session.clear
    redirect_to root_path, notice: "You are now logged out"
  end
end