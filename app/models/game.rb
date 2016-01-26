# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rounds     :integer          default(10)
#  single     :boolean          default(FALSE)
#
# Indexes
#
#  index_games_on_creator_id  (creator_id)
#

class Game < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  has_many :players
  has_many :users, :through => :players

  scope :single, -> { where(:single => true) }

  def answer!(user, params)
    player(user).answer! params
  end

  def finished?
    players(true).pluck(:finished_at).all?
  end

  def player(user)
    players.find_by(:user => user)
  end

  private

  before_create :setup_creators_player
  before_save :set_single_flag

  def setup_creators_player
    self.players.build(:user => creator)
  end

  def set_single_flag
    self.single = self.players.size < 2
    return true
  end
end
