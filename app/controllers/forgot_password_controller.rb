class ForgotPasswordController < ApplicationController

  def forgot_password
    @user = User.new

  end

  def send_password
    user = User.find_by_email(params[:user][:email])
    if user
      user.password_reset_token = SecureRandom.urlsafe_base64
      user.password_expires_after = 24.hours.from_now
      user.save
      Notifier.forgot_password(user).deliver
      flash[:notice] = "Email with instructions on reseting your password has been sent"
      redirect_to '/sessions/new'
    else
      @user = User.new
      flash[:notice] = "fuck you"

      render :forgot_password
    end
  end

  def password_reset
    token = params.first[0]
    @user = User.find_by_password_reset_token(token)
    if @user.nil?
      flash[:error] = 'You have not requested a password reset.'
      redirect_to :root
      return
    end

    if @user.password_expires_after < DateTime.now
      clear_password_reset(@user)
      @user.save
      flash[:error] = 'Password reset has expired. Please request a new password reset.'
      redirect_to :forgot_password
    end
  end


  def change_password
    email = params[:user][:email]
    new_password = params[:user][:new_password]
    confirmation = params[:user][:new_password_confirmation]
    @user = User.find_by_email(email)

   if @user.update_password(@user, new_password, confirmation)
      flash[:notice] = 'Your password has been reset. Please sign in with your new password.'
      redirect_to '/sessions/new'
   else
     render :password_reset
    end
end

end






