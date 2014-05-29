class Notifier < ActionMailer::Base
  default :from => 'notifications@g2-newsletter.com'

  def welcome_email(user)
    @user = user
    mail( :to => @user.email,
          :subject => 'Thank you for signing up!' )
  end

  def forgot_password(user)
    @user = user
    @password_reset_url = 'http://localhost:3000/password_reset?' + @user.password_reset_token
    mail(:to => user.email, :subject => 'Password Reset Instructions.')
  end
end