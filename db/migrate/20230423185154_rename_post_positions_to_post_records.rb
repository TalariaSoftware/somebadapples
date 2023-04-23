class RenamePostPositionsToPostRecords < ActiveRecord::Migration[7.0]
  def change
    rename_table :post_positions, :post_records
  end
end
