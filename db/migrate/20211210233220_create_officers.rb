class CreateOfficers < ActiveRecord::Migration[7.0]
  def change
    create_table :officers do |t|
      t.string :first_name
      t.string :last_name
      t.string :serial_number
      t.string :badge_number

      t.timestamps
    end
  end
end
