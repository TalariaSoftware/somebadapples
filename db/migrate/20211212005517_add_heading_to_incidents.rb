class AddHeadingToIncidents < ActiveRecord::Migration[7.0]
  def change
    add_column :incidents, :heading, :string, null: false, default: ''
  end
end
