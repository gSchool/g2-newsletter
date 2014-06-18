class Article < ActiveRecord::Base
  belongs_to :publication
  validates :title, presence: true
  validates :description, presence: true
end