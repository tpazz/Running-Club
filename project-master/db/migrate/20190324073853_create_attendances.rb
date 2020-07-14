class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :schedule, foreign_key: true
      t.references :child, foreign_key: true
      t.integer :attended

      t.timestamps
    end
  end
end
