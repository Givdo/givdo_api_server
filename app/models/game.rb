# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  single     :boolean          default(TRUE)
#
# Indexes
#
#  index_games_on_creator_id  (creator_id)
#

class Game < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  has_many :players
  has_many :users, :through => :players
  has_and_belongs_to_many :trivias

  attr_accessor :rounds

  scope :single, -> { where(:single => true) }
  scope :versus, -> (user) { joins(:players).where(:single => false).where('players.user_id' => user.id) }

  def answer!(user, params)
    player(user).answer! params
  end

  def next_trivia(user)
    answered = player(user).answers.pluck(:trivia_id)
    trivias.excluding(answered).first
  end

  def winner
    return unless finished?
    players
      .select('count(answers.correct) as points, players.*')
      .joins(:answers)
      .order('points DESC').first
  end

  def finished?
    players(true).pluck(:finished_at).all?
  end

  def player(user)
    players.find_by(:user => user)
  end

  def rounds
    @rounds || 10
  end

  def add_player(user)
    players.build(:user => user).tap do
      self.single = players.size < 2
    end
  end

  private

  before_create :setup_creators_player
  before_save :raffle_trivias

  def raffle_trivias
    missing = self.rounds - self.trivias.size
    self.trivias << TriviaRaffle.raffle(self, missing)
  end

  def setup_creators_player
    add_player(creator)
  end
end
