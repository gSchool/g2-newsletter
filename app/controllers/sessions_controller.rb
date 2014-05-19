class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by_email(email)

    if user.present? && decrypted_password(user.password_digest) == password
      session[:id] = user.id
      flash[:notice] = "Welcome back #{user.email}"
      redirect_to root_path
    else
      flash[:notice] = "Email or password incorrect"
      render :new
    end

  end


  def destroy
    session.clear
    flash[:notice] = "You have logged out."

    redirect_to root_path
  end

  private
  def decrypted_password(password)
    BCrypt::Password.new(password)
  end

end

