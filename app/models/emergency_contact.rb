# == Schema Information
#
# Table name: emergency_contacts
#
#  id           :bigint(8)        not null, primary key
#  phone        :string           not null
#  relationship :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  child_id     :bigint(8)        not null
#
# Indexes
#
#  index_emergency_contacts_on_child_id  (child_id)
#
# Foreign Keys
#
#  fk_rails_...  (child_id => children.id)
#

class EmergencyContact < ApplicationRecord
  belongs_to :child

  def to_s
    phone
  end
end
