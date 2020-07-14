# == Schema Information
#
# Table name: coaches
#
#  id          :bigint(8)        not null, primary key
#  appl_status :boolean          default(FALSE)
#  telephone   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint(8)        not null
#
# Indexes
#
#  index_coaches_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Coach < ApplicationRecord
  has_many :document, dependent: :destroy
  has_many :session_helper , dependent: :destroy
  has_many :button_clicks , dependent: :destroy
  has_many :schedule , through: :session_helper
  has_one :user
  accepts_nested_attributes_for :document
  validates_associated :document

  # Validation
  validate :validate_telephone

  def validate_telephone
    errors.add(:telephone, "Telephone is invalid") unless Validation.numeric_validation_space(telephone)
  end
end
