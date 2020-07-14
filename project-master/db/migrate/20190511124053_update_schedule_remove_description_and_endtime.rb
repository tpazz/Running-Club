class UpdateScheduleRemoveDescriptionAndEndtime < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :end_time
    remove_column :schedules, :description
  end
end
