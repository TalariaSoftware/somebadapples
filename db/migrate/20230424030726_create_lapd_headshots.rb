class CreateLapdHeadshots < ActiveRecord::Migration[7.0]
  def change
    create_table :lapd_headshots, id: :uuid do |t|
      t.string :file_name, null: false
      t.timestamps
    end
  end
end
