# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rounds     :integer          default(10)
#
# Indexes
#
#  index_games_on_creator_id  (creator_id)
#

class Game < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  has_many :answers
  has_many :players
  has_many :users, :through => :players

  def answer!(user, params)
    self.answers.create!(params.merge(:user => user))
  end

  private

  before_create :setup_creators_player

  def setup_creators_player
    self.players.build(:user => creator)
  end
end
