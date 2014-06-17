class Publication < ActiveRecord::Base
  has_many :subscriptions
  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true
end