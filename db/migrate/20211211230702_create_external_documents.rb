class CreateExternalDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :external_documents do |t|
      t.belongs_to :incident, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end
