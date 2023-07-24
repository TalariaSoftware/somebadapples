class DropLapdHeadshots < ActiveRecord::Migration[7.0]
  def change
    drop_table :lapd_headshots, id: :uuid do |t|
      t.string :file_name, null: false
      t.timestamps

      t.index :file_name, unique: true

      t.string :slug
      t.index :slug, unique: true
    end
  end
end
