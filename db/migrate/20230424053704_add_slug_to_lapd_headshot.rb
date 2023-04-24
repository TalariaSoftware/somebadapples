class AddSlugToLapdHeadshot < ActiveRecord::Migration[7.0]
  def change
    add_column :lapd_headshots, :slug, :string
    add_index :lapd_headshots, :slug, unique: true
  end
end
