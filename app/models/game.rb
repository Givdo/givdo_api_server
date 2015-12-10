# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_games_on_creator_id  (creator_id)
#

class Game < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  has_and_belongs_to_many :players, :class_name => 'User'
end
