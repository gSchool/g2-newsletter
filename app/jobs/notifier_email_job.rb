class NotifierEmailJob
  include SuckerPunch::Job
  def perform(user, hmac_token)
    ::Notifier.forgot_password(user, hmac_token).deliver
  end
end