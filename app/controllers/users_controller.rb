class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]

    @user = User.new(:email => email, :password => password, :password_confirmation => password_confirmation)
    if @user.save
        log_user_in(@user)
      flash[:notice] = "Welcome to the newsletter application"
      redirect_to root_path
    else
      render :new
    end
  end
end