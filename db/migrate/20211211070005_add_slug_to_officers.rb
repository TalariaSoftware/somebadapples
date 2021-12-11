class AddSlugToOfficers < ActiveRecord::Migration[7.0]
  def change
    add_column :officers, :slug, :string
    add_index :officers, :slug, unique: true
  end
end
