class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]

    @user = User.create(:email => email, :password => password)



    if @user.save

      session[:user_id] = @user.id

      redirect_to root_path, notice: "User Created"
    else
      render :new
    end
  end
end