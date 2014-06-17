class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :publication
  validates :user, presence: true
  validates :publication, presence: true
end