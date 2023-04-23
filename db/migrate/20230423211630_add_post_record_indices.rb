class AddPostRecordIndices < ActiveRecord::Migration[7.0]
  def change
    add_index :post_records, :officer_name
    add_index :post_records, :post_id
    add_index :post_records, :agency
    add_index :post_records, :rank
  end
end
