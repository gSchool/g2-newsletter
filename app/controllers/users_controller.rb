class UsersController < SecureController
  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_parameters)
    if @user.save
      Notifier.welcome_email(@user).deliver
      log_user_in(@user)
      flash[:notice] = "Welcome to the newsletter application"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    
  end

  def allowed_parameters
    params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :admin,
        :password_reset_token,
        :password_expires_after,
        :terms_of_service
    )
  end
end
