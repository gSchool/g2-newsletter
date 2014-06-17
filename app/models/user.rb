class User < ActiveRecord::Base
  has_many :subscriptions
  has_secure_password
  validates :email, :presence => true, :uniqueness => true
  validates :email, format: {with: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,3}/, message: "must be a valid email address"}
  validates :password, length: {minimum: 8, message: "must be 8 or more characters", if: 'password.present?'}
  validates :terms_of_service, :acceptance => true

  def update_password(new_password, confirmation)
    self.password_digest = nil
    update_attributes(:password => new_password, :password_confirmation => confirmation)
  end
end


