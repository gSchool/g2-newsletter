class ForgotPasswordController < ApplicationController

  def forgot_password
    @user = User.new
  end

  def send_password
    if valid_email?(params[:user][:email])
      @user = User.find_by_email(params[:user][:email])

      if @user
        expired_time = 2.hours.from_now
        token = verifier.generate({id: @user.id, time: expired_time})
        NotifierEmailJob.new.async.perform(@user, token)
      end

      flash[:notice] = "Email with instructions on resetting your password has been sent"
      render '/sessions/new'
    else
      flash[:notice] = "Please enter a valid email address"
      redirect_to forgot_password_path
    end
  end

  def password_reset
    token = params[:token]
    user_info = verifier.verify(token)
    expiration_time = user_info[:time]

    if Time.now <= expiration_time
      @user = User.find_by(id: user_info[:id])
      if @user.nil?
        flash[:error] = 'You have not requested a password reset.'
        redirect_to forgot_password_path
      end
    else
      flash[:error] = 'Your password reset token has expired. Request a new password by clicking Forgot Password.'
      redirect_to forgot_password_path
    end
  end

  def change_password
    email = params[:user][:email]
    new_password = params[:user][:new_password]
    confirmation = params[:user][:new_password_confirmation]
    @user = User.find_by_email(email)

    if @user.update_attributes(password: new_password.presence, password_confirmation: confirmation.presence)
      flash[:notice] = 'Your password has been reset. Please sign in with your new password.'
      redirect_to '/sessions/new'
    else
      render :password_reset
    end
  end

  private

  def verifier
    ActiveSupport::MessageVerifier.new(Rails.application.secrets.secret_key_base)
  end

  def valid_email?(email)
    !!/([a-z\d._-]+)@([a-z\d._-]{2,}).([a-z\d._-]{3,})/i.match(email)
  end
end