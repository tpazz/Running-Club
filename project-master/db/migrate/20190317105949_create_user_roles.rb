class CreateUserRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_roles do |t|
      t.references :role, foreign_key: true
      t.references :user, as: :user, foreign_key: true

      t.timestamps
    end
  end
end
