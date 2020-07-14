class CreateCoaches < ActiveRecord::Migration[5.2]
  def change
    create_table :coaches do |t|
      t.references :user, foreign_key: true, null: false
      t.string :telephone
      t.string :DBS
      t.string :safe_qual
      t.string :first_aid
      t.string :coach_qual
      t.boolean :appl_status, default: false

      t.timestamps
    end
  end
end
