class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.references :coach, foreign_key: true
      t.string :attachment

      t.timestamps
    end
  end
end
