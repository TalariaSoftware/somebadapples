class CreateUsCaLosAngelesPoliceHeadshots20230321Headshots < ActiveRecord::Migration[7.0] # rubocop:disable Layout/LineLength
  def change
    create_table :us_ca_los_angeles_police_headshots20230321_headshots,
      id: :uuid do |t|
      t.string :file_name, null: false
      t.string :slug
      t.timestamps

      t.index :file_name, unique: true, name: 'by_file_name'
      t.index :slug, name: 'by_slug', unique: true
    end
  end
end
