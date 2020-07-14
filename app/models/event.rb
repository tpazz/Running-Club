# == Schema Information
#
# Table name: events
#
#  id         :bigint(8)        not null, primary key
#  date       :date
#  details    :string
#  name       :string
#  series     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ApplicationRecord
end
