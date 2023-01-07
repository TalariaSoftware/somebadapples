class CreatePostPositions < ActiveRecord::Migration[7.0]
  def change
    create_table :post_positions, id: :uuid do |t|
      t.string :officer_id, null: false, default: ''
      t.string :officer_name, null: false, default: ''
      t.string :post_id, null: false, default: ''
      t.string :agency, null: false, default: ''
      t.string :employment_start_date, null: false, default: ''
      t.string :employment_end_date, null: false, default: ''
      t.string :rank, null: false, default: ''

      t.belongs_to :position

      t.timestamps
    end
  end
end
