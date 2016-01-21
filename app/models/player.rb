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

  def rounds_left
    self.game.rounds_left(self.user)
  end
end
