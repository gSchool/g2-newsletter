class Publication < ActiveRecord::Base
  has_many :subscriptions
  has_many :articles
  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true
end