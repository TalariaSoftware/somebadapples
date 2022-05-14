class CreateAgencies < ActiveRecord::Migration[7.0]
  def change
    create_table :agencies, id: :uuid do |t|
      t.string :name, null: false, default: ''
      t.string :short_name, null: false, default: ''

      t.timestamps
    end

    create_table :positions, id: :uuid do |t|
      t.belongs_to :officer, null: false, type: :uuid, foreign_key: true
      t.belongs_to :agency, null: false, type: :uuid, foreign_key: true

      t.string :badge_number
      t.string :serial_number

      t.timestamps
    end
  end
end
