class ChangeDocumentsColumnName < ActiveRecord::Migration
  def change
    rename_column :documents, :case_document, :document
  end
end