# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  token      :string
#  platform   :string
#  enabled    :boolean          default(TRUE)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_devices_on_user_id  (user_id)
#

class Device < ActiveRecord::Base
  validates :token, presence: true

  validates_uniqueness_of :token, scope: :user_id

  belongs_to :user
end
