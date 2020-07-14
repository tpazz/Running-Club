# == Schema Information
#
# Table name: attendances
#
#  id          :bigint(8)        not null, primary key
#  attended    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  child_id    :bigint(8)
#  schedule_id :bigint(8)
#
# Indexes
#
#  index_attendances_on_child_id     (child_id)
#  index_attendances_on_schedule_id  (schedule_id)
#
# Foreign Keys
#
#  fk_rails_...  (child_id => children.id)
#  fk_rails_...  (schedule_id => schedules.id)
#

class Attendance < ApplicationRecord
  validates :schedule, uniqueness: { scope: :child }
  belongs_to :child
  belongs_to :schedule
end
