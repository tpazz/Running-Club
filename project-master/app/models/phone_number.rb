# == Schema Information
#
# Table name: phone_numbers
#
#  id           :bigint(8)        not null, primary key
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  parent_id    :bigint(8)        not null
#
# Indexes
#
#  index_phone_numbers_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => parents.id)
#

class PhoneNumber < ApplicationRecord
  belongs_to :parent

  validate :validate_phone_number

  def validate_phone_number
    errors.add(:phone_number, "Phone Number is invalid") unless phone_number.blank? || Validation.numeric_validation_space(phone_number)
  end
end
