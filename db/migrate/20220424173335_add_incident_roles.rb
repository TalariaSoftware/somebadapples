class AddIncidentRoles < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :external_documents, :incidents

    rename_table :incidents, :deprecated_incidents

    create_table :incidents do |t|
      t.string :heading, null: false, default: ''
      t.string :description, null: false, default: ''
      t.datetime :datetime

      t.timestamps
    end

    create_table :incident_roles do |t|
      t.belongs_to :officer, null: false, foreign_key: true
      t.belongs_to :incident, null: false, foreign_key: true
      t.string :description, null: false, default: ''

      t.timestamps
    end
  end
end
