class AddParentToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :parents, foreign_key: true
    remove_column :parents, :users_id
    # Change to singular, to use helper methods and simple form
    add_column :parents, :user_id, :integer, index: true
    add_foreign_key :parents, :users, column: :user_id
  end
end
