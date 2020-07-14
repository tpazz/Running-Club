class MakeGroupOptional < ActiveRecord::Migration[5.2]
  def change
    change_column_null :children, :group_id, true
  end
end
