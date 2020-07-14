class AddBooleanCoachLeaderToSessionhelper < ActiveRecord::Migration[5.2]
  def change
    add_column :session_helpers, :team_leader, :boolean, default: false
    remove_column :schedules, :coach_id
  end
end
