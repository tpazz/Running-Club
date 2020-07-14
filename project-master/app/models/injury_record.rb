# == Schema Information
#
# Table name: injury_records
#
#  id              :bigint(8)        not null, primary key
#  injury          :string
#  parent_notified :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  child_id        :bigint(8)
#  schedule_id     :bigint(8)
#
# Indexes
#
#  index_injury_records_on_child_id     (child_id)
#  index_injury_records_on_schedule_id  (schedule_id)
#
# Foreign Keys
#
#  fk_rails_...  (child_id => children.id)
#  fk_rails_...  (schedule_id => schedules.id)
#

class InjuryRecord < ApplicationRecord
  belongs_to :child
  belongs_to :schedule 
end
