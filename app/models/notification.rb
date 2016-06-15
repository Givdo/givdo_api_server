# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  user_id    :integer
#  sender_id  :integer
#  status     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_notifications_on_game_id    (game_id)
#  index_notifications_on_sender_id  (sender_id)
#  index_notifications_on_user_id    (user_id)
#

class Notification < ActiveRecord::Base
  enum status: { no_answer: 0, accepted: 1, rejected: 2 }

  belongs_to :game
  belongs_to :user
  belongs_to :sender, class_name: 'User'
end
