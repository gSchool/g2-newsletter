class User < ActiveRecord::Base
  has_secure_password

  validates :email, :presence => true, :uniqueness => true
  validates :email, format: {with:/[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,3}/, message: "Must be a valid email address" }
  validates :password, length: {minimum: 8, message: "Password must be 8 or more characters", if: 'password.present?'}


end


