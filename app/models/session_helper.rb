# == Schema Information
#
# Table name: session_helpers
#
#  id          :bigint(8)        not null, primary key
#  team_leader :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  coach_id    :bigint(8)
#  schedule_id :bigint(8)
#
# Indexes
#
#  index_session_helpers_on_coach_id     (coach_id)
#  index_session_helpers_on_schedule_id  (schedule_id)
#
# Foreign Keys
#
#  fk_rails_...  (coach_id => coaches.id)
#  fk_rails_...  (schedule_id => schedules.id)
#

class SessionHelper < ApplicationRecord
  validates :schedule, uniqueness: { scope: :coach }
  belongs_to :schedule
  belongs_to :coach
end
