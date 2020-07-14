class AddInactiveToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :inactive, :boolean, default: false
  end
end
