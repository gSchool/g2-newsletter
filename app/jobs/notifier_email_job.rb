class NotifierEmailJob
  include SuckerPunch::Job

  def perform(user, token = nil)
    if token.present?
      ::Notifier.forgot_password(user, token).deliver
    else
      ::Notifier.welcome_email(user).deliver
    end
  end

  def subscription(user, article)
    ::Notifier.new_article(user, article).deliver
  end
end
