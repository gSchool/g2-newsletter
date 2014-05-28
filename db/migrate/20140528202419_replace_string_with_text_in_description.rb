class ReplaceStringWithTextInDescription < ActiveRecord::Migration
  def change
      change_column :publications, :description, :text
  end
end

