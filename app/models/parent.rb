# == Schema Information
#
# Table name: parents
#
#  id           :bigint(8)        not null, primary key
#  address      :string
#  home_number  :string
#  postcode     :string
#  prime_mobile :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Parent < ApplicationRecord
  has_many :child , dependent: :destroy
  has_many :phone_number , dependent: :destroy
  belongs_to :user, dependent: :destroy, :foreign_key => 'user_id', optional: true
  accepts_nested_attributes_for :phone_number
  validates_associated :phone_number

  def to_s
    User.find(user_id).first_name + ' ' + User.find(user_id).last_name
  end

  # Validation
  validate :validate_address
  validate :validate_phone_number

  def validate_address
    errors.add(:address, "Address is invalid") unless Validation.alphanumeric_validation(address)
    errors.add(:postcode, "Postcode is invalid") unless Validation.alphanumeric_validation(postcode)
  end

  def validate_phone_number
    errors.add(:home_number, "Home Number is invalid") unless home_number.blank? || Validation.numeric_validation_space(home_number)
    errors.add(:prime_mobile, "Phone Number is invalid") unless Validation.numeric_validation_space(prime_mobile)
  end
end
