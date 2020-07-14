# == Schema Information
#
# Table name: mail_models
#
#  id         :bigint(8)        not null, primary key
#  mail       :string
#  message    :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MailModel < ApplicationRecord
end
