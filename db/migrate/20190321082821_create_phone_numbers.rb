class CreatePhoneNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_numbers do |t|
      t.references :parent, foreign_key: true, null: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end
