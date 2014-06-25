class DropPasswordResetToken < ActiveRecord::Migration
  def change
    remove_column :users, :password_reset_token
  end
end
