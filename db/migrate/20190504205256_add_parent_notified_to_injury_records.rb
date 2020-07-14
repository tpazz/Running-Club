class AddParentNotifiedToInjuryRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :injury_records, :parent_notified, :boolean, default: false
  end
end
