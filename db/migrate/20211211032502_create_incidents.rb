class CreateIncidents < ActiveRecord::Migration[7.0]
  def change
    create_table :incidents do |t|
      t.datetime :datetime
      t.string :description, null: false, default: ''
      t.belongs_to :officer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
