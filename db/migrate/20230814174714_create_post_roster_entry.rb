class CreatePostRosterEntry < ActiveRecord::Migration[7.0]
  def change
    create_table :us_ca_post_roster2022_entries, id: :uuid do |t|
      t.integer :officer_id, null: false, index: { unique: true }
      t.string :officer_name, null: false
      t.string :post_id, null: false, index: true
      t.string :agency, null: false, index: true
      t.date :employment_start_date, null: false
      t.date :employment_end_date
      t.string :rank, null: false

      t.timestamps
    end
  end
end
