class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password_digest]

    @user = User.new(:email => email, :password_digest => password)


    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome"
      redirect_to root_path
    else
      render :new
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end
end