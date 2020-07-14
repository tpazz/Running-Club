class CreateInjuryRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :injury_records do |t|
      t.references :child, foreign_key: true
      t.string :injury
      t.references :schedule, foreign_key: true

      t.timestamps
    end
  end
end
