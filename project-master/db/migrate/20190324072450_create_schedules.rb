class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :group, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.references :coach, foreign_key: true
      t.string :description
      t.string :session_type

      t.timestamps
    end
  end
end
