# == Schema Information
#
# Table name: documents
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  expiration  :date
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  coach_id    :bigint(8)
#
# Indexes
#
#  index_documents_on_coach_id  (coach_id)
#
# Foreign Keys
#
#  fk_rails_...  (coach_id => coaches.id)
#

class Document < ApplicationRecord
  belongs_to :coach
end
