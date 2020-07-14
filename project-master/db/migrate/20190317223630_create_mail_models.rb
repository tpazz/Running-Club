class CreateMailModels < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_models do |t|
      t.string :mail
      t.text :message
      t.string :name

      t.timestamps
    end
  end
end
