class Notifier < ActionMailer::Base
  default :from => 'notifications@g2-newsletter.com'

  def welcome_email(user)
    @user = user
    mail( :to => @user.email,
          :subject => 'Thank you for signing up!' )
  end

  def forgot_password(user, hmac_token)
    @user = user
    @password_reset_token = hmac_token
    mail(:to => user.email, :subject => 'Password Reset Instructions.')
  end

  def new_article(user, article)
    @user = user
    @article = article
    mail( :to => @user.email,
          :subject => "A new article has been added to #{@article.publication.name}")
  end
end