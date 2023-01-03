class AddDatesAndRankToPositions < ActiveRecord::Migration[7.0]
  def change
    add_column :positions, :employment_start, :date
    add_column :positions, :employment_end, :date
    add_column :positions, :rank, :string
  end
end
