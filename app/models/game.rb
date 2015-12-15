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
  has_many :players
  has_many :users, :through => :players

  private

  before_create :setup_creators_player

  def setup_creators_player
    self.players.build(:user => creator)
  end
end
