class AddAgencyNameIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :agencies, :name, unique: true
  end
end
