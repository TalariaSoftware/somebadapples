class CreatePostPositions < ActiveRecord::Migration[7.0]
  def change
    create_table :post_positions, id: :uuid do |t|
      t.string :officer_id
      t.string :officer_name
      t.string :post_id
      t.string :agency
      t.string :employment_start_date
      t.string :employment_end_date
      t.string :rank

      t.belongs_to :position

      t.timestamps
    end
  end
end
