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
#  finished_at     :datetime
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

  scope :finished, -> { where.not(players: { finished_at: nil }) }

  def has_rounds?
    rounds_left > 0
  end

  def rounds_left
    game.rounds - answers.count
  end

  def answer!(params)
    answers.create!(params)
  end

  def finish!
    self.tap do |player|
      player.touch(:finished_at)
    end
  end

  def finished?
    finished_at.present?
  end

  def winner?
    self.eql?(self.game.winner)
  end

  def create_user_activity!
    user.activities.create!(subject: self, name: activity_name)
  end

  private

  before_validation :copy_user_organization

  def copy_user_organization
    self.organization ||= user.try(:organization)
  end

  def activity_name
    winner? ? 'won_scores' : 'lost_scores'
  end
end
