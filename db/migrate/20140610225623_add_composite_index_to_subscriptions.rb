class AddCompositeIndexToSubscriptions < ActiveRecord::Migration
  def change
    add_index :subscriptions, [ :user_id, :publication_id ], :unique => true, name: 'user_publication_id'
  end
end
