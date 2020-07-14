# == Schema Information
#
# Table name: groups
#
#  id           :bigint(8)        not null, primary key
#  group_colour :string
#  group_name   :string
#  inactive     :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Group < ApplicationRecord
  has_many :child
  has_many :schedule
  def to_s
    group_name
  end
end
