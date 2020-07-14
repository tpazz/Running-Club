# == Schema Information
#
# Table name: roles
#
#  id         :bigint(8)        not null, primary key
#  role_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ApplicationRecord
  has_many :user_roles , dependent: :destroy
  has_many :users, through: :user_roles

  def to_s
    role_name
  end
end
