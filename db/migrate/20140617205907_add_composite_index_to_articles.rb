class AddCompositeIndexToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :publication_id, :integer
    add_index :articles, [:publication_id ], name: 'publication_id'
  end
end
