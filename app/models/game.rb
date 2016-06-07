# == Schema Information
#
# Table name: games
#
#  id          :integer          not null, primary key
#  creator_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  single      :boolean          default(TRUE)
#  category_id :integer
#
# Indexes
#
#  index_games_on_creator_id  (creator_id)
#

class Game < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  belongs_to :category

  has_many :players
  has_many :users, :through => :players

  has_and_belongs_to_many :trivias

  attr_accessor :rounds

  scope :unfinished, -> { where('players.finished_at' => nil) }
  scope :single, -> { where(:single => true) }

  def self.versus(user)
    p2_table = connection.quote_table_name('players')
    p2_alias = connection.quote_table_name('player2')
    joins("INNER JOIN #{p2_table} #{p2_alias} ON games.id = #{p2_alias}.game_id").
      where('player2.user_id' => user.id)
  end

  def answer!(user, params)
    Player::SaveAnswer.call(player(user), params)
  end

  def next_trivia(user)
    answered = player(user).answers.pluck(:trivia_id)
    trivias.excluding(answered).first
  end

  def winner
    return unless finished?
    players.order(:score => :desc).first
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

  # TODO: move callbacks to a builder class
  before_create :setup_creators_player
  before_save :assign_default_category
  before_save :raffle_trivias

  def raffle_trivias
    missing = self.rounds - self.trivias.size
    self.trivias << TriviaRaffle.raffle(self, missing)
  end

  def setup_creators_player
    add_player(creator)
  end

  def assign_default_category
    self.category ||= Category.other
  end
end
