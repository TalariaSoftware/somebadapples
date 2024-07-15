class AddPostRecordsNullConstraints < ActiveRecord::Migration[7.0]
  def change
    change_column_null :post_records, :officer_id, false # rubocop:disable Rails/BulkChangeTable
    change_column_null :post_records, :officer_name, false
    change_column_null :post_records, :post_id, false
    change_column_null :post_records, :agency, false
    change_column_null :post_records, :employment_start_date, false
    change_column_null :post_records, :rank, false
  end
end
