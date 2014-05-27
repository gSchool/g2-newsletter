class Publication < ActiveRecord::Base
validates :name, :presence => true
end