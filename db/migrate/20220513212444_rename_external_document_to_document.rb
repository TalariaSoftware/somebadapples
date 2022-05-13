class RenameExternalDocumentToDocument < ActiveRecord::Migration[7.0]
  def change
    rename_table :external_documents, :documents
  end
end
