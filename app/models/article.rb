class Article < ActiveRecord::Base
  belongs_to :publication
  validates :title, presence: true
  validates :description, presence: true

  after_create :send_emails

  def send_emails
    users = self.publication.subscriptions.includes(:user).map{|sub| sub.user}
    users.each do |user|
      NotifierEmailJob.new.async.subscription(user, self)
    end
  end
end