class AddUniqueIndexToPostId < ActiveRecord::Migration[7.0]
  def change
    add_index :officers, :post_id, unique: true
  end
end
