class AddNameFields < ActiveRecord::Migration[7.0]
  def change
    change_table :officers, bulk: true do |t|
      t.string :middle_name, null: false, default: ''
      t.string :suffix, null: false, default: ''
    end
  end
end
