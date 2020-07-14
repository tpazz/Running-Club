# == Schema Information
#
# Table name: children
#
#  id              :bigint(8)        not null, primary key
#  collected       :boolean
#  date_of_birth   :date             not null
#  doctor_address  :string
#  doctor_name     :string
#  doctor_postcode :string
#  first_name      :string           not null
#  gender          :integer
#  inactive_days   :integer          default(0)
#  last_name       :string           not null
#  medical_issues  :string
#  paid            :boolean          default(FALSE)
#  photo           :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  group_id        :bigint(8)
#  parent_id       :bigint(8)        not null
#
# Indexes
#
#  index_children_on_group_id   (group_id)
#  index_children_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (parent_id => parents.id)
#

class Child < ApplicationRecord

  def to_s
    first_name + ' ' + last_name
  end

  # Validation
  validates_inclusion_of :gender, :in => 0..2,
    message: "Invalid gender"

  validates_inclusion_of :photo, :in => 0..2,
    message: "Invalid photo option"

  validate :validate_date, on: :create
  validate :validate_name
  validate :validate_doctor
  # Assosications
  belongs_to :group, optional: true
  belongs_to :parent
  has_many :emergency_contact , dependent: :destroy
  has_many :attendance , dependent: :destroy
  has_many :injury_record , dependent: :destroy
  has_many :button_click , dependent: :destroy

  private

  def validate_date
    errors.add(:date_of_birth, "You must be between 8 and 16 years old") unless !date_of_birth.blank? && get_age(date_of_birth) >= 8 && get_age(date_of_birth) <= 16
  end

  # Input: Date
  # Return: The age of the user (Integer, not decimal), return -1 if error
  def get_age(date)
    today = Time.now
    begin
      years = today.year - date.year - 1
      # If date month is higher, they are +1 since they had birthday his year too
      if today.month < date.month
        return years + 1
      end
      # If date month is equal, check if day is higher
      if today.month == date.month
        return today.day >= date.day ? years + 1 : years
      end
      # Else, return years
      return years
    rescue
      return -1
    end
  end

  def validate_name
    errors.add(:first_name, "First name is invalid") unless Validation.alphabet(first_name)
    errors.add(:last_name, "Last name is invalid") unless Validation.alphabet(last_name)
  end

  # Note: The doctor fields are optional, but if entered they must be valid
  def validate_doctor
    errors.add(:doctor_address, "Doctor address is invalid") unless doctor_address.blank? || Validation.alphanumeric_validation(doctor_address)
    errors.add(:doctor_name, "Doctor name is invalid") unless doctor_name.blank? || Validation.alphabet(doctor_name)
    errors.add(:doctor_postcode, "Doctor postcode is invalid") unless doctor_postcode.blank? || Validation.alphanumeric_validation(doctor_postcode)
  end
end
