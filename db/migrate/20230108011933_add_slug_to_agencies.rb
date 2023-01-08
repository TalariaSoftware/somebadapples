class AddSlugToAgencies < ActiveRecord::Migration[7.0]
  def change
    add_column :agencies, :slug, :string, unique: true
  end
end
