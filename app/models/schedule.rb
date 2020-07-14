# == Schema Information
#
# Table name: schedules
#
#  id           :bigint(8)        not null, primary key
#  location     :string
#  session_type :string
#  start_time   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  group_id     :bigint(8)
#
# Indexes
#
#  index_schedules_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#

class Schedule < ApplicationRecord
  has_many :session_helper
  has_many :attendance ,   dependent:   :destroy
  has_many :injury_record, dependent: :destroy
  has_many :coach , through: :session_helper
  belongs_to :group

  def to_s
    start_time.strftime("%d/%m/%Y") + " " + Group.find(group_id).group_name
  end
end
