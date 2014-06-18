class NotifierEmailJob
  include SuckerPunch::Job

  def perform(user, hmac_token = nil)
    if hmac_token.present?
      ::Notifier.forgot_password(user, hmac_token).deliver
    else
      ::Notifier.welcome_email(user).deliver
    end
  end

  def subscription(user, article)
    ::Notifier.new_article(user, article).deliver
  end
end
