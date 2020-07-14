class CreateParents < ActiveRecord::Migration[5.2]
  def change
    create_table :parents do |t|
      t.string :address
      t.string :postcode
      t.string :home_number
      t.string :prime_mobile

      t.timestamps
    end
  end
end
