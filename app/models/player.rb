# == Schema Information
#
# Table name: players
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  game_id         :integer
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  finished_at     :datetime         default(NULL)
#
# Indexes
#
#  index_players_on_game_id          (game_id)
#  index_players_on_organization_id  (organization_id)
#  index_players_on_user_id          (user_id)
#

class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  belongs_to :organization
  has_many :answers

  def has_rounds?
    rounds_left > 0
  end

  def rounds_left
    game.rounds - self.answers(true).count
  end

  def score
    self.answers.correct.count
  end

  def answer!(params)
    self.answers.create!(params) do
      finish! unless has_rounds?
    end
  end

  def finish!
    touch(:finished_at)
  end
end
