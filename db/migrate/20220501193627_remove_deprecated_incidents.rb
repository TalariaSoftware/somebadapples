class RemoveDeprecatedIncidents < ActiveRecord::Migration[7.0]
  def change
    drop_table :deprecated_incidents do |t|
      t.datetime :datetime
      t.string :heading, null: false, default: ''
      t.string :description, null: false, default: ''
      t.belongs_to :officer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
