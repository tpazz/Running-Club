class CreateEmergencyContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :emergency_contacts do |t|
      t.references :child, foreign_key: true, null: false
      t.string :phone, null: false
      t.string :relationship

      t.timestamps
    end
  end
end
