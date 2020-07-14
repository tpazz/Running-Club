class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.date :date
      t.string :name
      t.boolean :series
      t.string :details

      t.timestamps
    end
  end
end
