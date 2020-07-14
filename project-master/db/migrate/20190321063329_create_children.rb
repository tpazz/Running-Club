class CreateChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :children do |t|
      t.references :group, foreign_key: true, null: false
      t.references :parent, foreign_key: true, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :gender
      t.date :date_of_birth, null: false
      t.integer :photo, default: 0
      t.integer :inactive_days, default: 0
      t.string :medical_issues
      t.boolean :collected
      t.boolean :paid, default: false
      t.string :doctor_name
      t.string :doctor_address
      t.string :doctor_postcode

      t.timestamps
    end
  end
end
