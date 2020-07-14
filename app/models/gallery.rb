# == Schema Information
#
# Table name: galleries
#
#  id                 :bigint(8)        not null, primary key
#  photo_content_type :string
#  photo_file_name    :string
#  photo_file_size    :bigint(8)
#  photo_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Gallery < ApplicationRecord
  has_attached_file :photo, path: ":rails_root/secure_files/:class/:attachment/:id_partition/:style/:filename.", url: "/images/:id/display"
  validates_attachment :photo, presence: true,
  content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
  size: { in: 0..4096.kilobytes }
end
