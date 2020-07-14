class CreateSessionHelpers < ActiveRecord::Migration[5.2]
  def change
    create_table :session_helpers do |t|
      t.references :schedule, foreign_key: true
      t.references :coach, foreign_key: true

      t.timestamps
    end
  end
end
