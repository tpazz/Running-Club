# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  s_email                :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  coaches_id             :bigint(8)
#  parents_id             :bigint(8)
#
# Indexes
#
#  index_users_on_coaches_id            (coaches_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_parents_id            (parents_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (coaches_id => coaches.id)
#  fk_rails_...  (parents_id => parents.id)
#

class User < ApplicationRecord
  has_many :user_roles , dependent: :destroy
  has_many :roles, through: :user_roles
  has_one :parent
  has_one :coach
  accepts_nested_attributes_for :parent
  accepts_nested_attributes_for :coach
  validates_associated :parent
  validates_associated :coach
  validate :validate_password, on: :create
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :validate_name
  validate :validate_mail

  def validate_name
    errors.add(:first_name, "First Name is invalid") unless Validation.alphabet(first_name)
    errors.add(:last_name, "Last Name is invalid") unless Validation.alphabet(last_name)
  end

  def validate_mail
    errors.add(:email, "Email is invalid") unless Validation.email_validation(email)
    errors.add(:s_email, "Secondary Email is invalid") unless s_email.blank? || Validation.email_validation(s_email)
  end

  def validate_password
    errors.add(:password, "Password is invalid, must contain 1 uppercase, 1 lowercase and 1 number") unless Validation.password_validation(password)
  end

  def to_s
    first_name + " " + last_name
  end

end
