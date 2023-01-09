class AddNameOrderIndices < ActiveRecord::Migration[7.0]
  def change
    add_index :officers, %i[last_name first_name middle_name], order: :desc

    remove_index :agencies, :name, unique: true
    add_index :agencies, :name, unique: true, order: :desc
  end
end
