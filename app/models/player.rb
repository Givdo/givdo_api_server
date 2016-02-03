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
    game.rounds - answers.count
  end

  def score
    answers.correct.count
  end

  def answer!(params)
    answer = answers.create!(params)
    finish! unless has_rounds?
    answer
  end

  def finish!
    touch(:finished_at)
  end

  def finished?
    finished_at.present?
  end

  private

  before_validation :copy_user_organization

  def copy_user_organization
    self.organization ||= user.try(:organization)
  end
end
