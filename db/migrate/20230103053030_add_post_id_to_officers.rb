class AddPostIdToOfficers < ActiveRecord::Migration[7.0]
  def change
    add_column :officers, :post_id, :string, unique: true
  end
end
