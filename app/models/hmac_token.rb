class HmacToken
  def self.password_reset(user)
    verifier = Rails.application.message_verifier(:password_reset)
    verifier.generate({:user_id => user.id, expiration: 2.hours.from_now})
  end

  def self.verify_password_reset_token(token)
    verifier = Rails.application.message_verifier(:password_reset)
    begin
      decrypted_hash = verifier.verify(token)
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      raise StandardError
    end
    if Time.now < decrypted_hash[:expiration]
      decrypted_hash[:user_id]
    else
      flash[:notice] = "You took too long to reset password"
      redirect_to '/'
    end
  end
end
