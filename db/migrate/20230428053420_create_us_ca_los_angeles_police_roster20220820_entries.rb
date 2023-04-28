class CreateUsCaLosAngelesPoliceRoster20220820Entries < ActiveRecord::Migration[7.0] # rubocop:disable Layout/LineLength
  def change
    create_table :us_ca_los_angeles_police_roster20220820_entries,
      id: :uuid do |t|
      t.string :employee_name, null: false
      t.string :serial_no, null: false
      t.string :rank_tile, null: false
      t.string :area, null: false
      t.string :sex, null: false
      t.string :ethicity, null: false

      t.index :serial_no, unique: true, name: 'by_serial_no'

      t.timestamps
    end
  end
end
