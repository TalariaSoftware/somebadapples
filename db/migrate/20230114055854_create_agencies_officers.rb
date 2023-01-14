class CreateAgenciesOfficers < ActiveRecord::Migration[7.0]
  def change
    create_view :agencies_officers, materialized: true

    add_index :agencies_officers, :officer_id
    add_index :agencies_officers, :agency_id
  end
end
