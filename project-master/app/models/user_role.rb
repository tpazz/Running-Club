# == Schema Information
#
# Table name: user_roles
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_id    :bigint(8)
#  user_id    :bigint(8)
#
# Indexes
#
#  index_user_roles_on_role_id  (role_id)
#  index_user_roles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#  fk_rails_...  (user_id => users.id)
#

class UserRole < ApplicationRecord
  belongs_to :role 
  belongs_to :user 
end
