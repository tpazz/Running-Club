class ChangeDocumentsForCoach < ActiveRecord::Migration[5.2]
  def change
    # Removing documents from coach table
    remove_column :coaches, :DBS
    remove_column :coaches, :coach_qual
    remove_column :coaches, :first_aid
    remove_column :coaches, :safe_qual
    # Updating Documents table
    remove_column :documents, :attachment
    add_column :documents, :title, :string, null: false
    add_column :documents, :expiration, :date
    add_column :documents, :description, :text
  end
end
