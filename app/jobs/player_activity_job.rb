class PlayerActivityJob < ActiveJob::Base
  queue_as :urgent

  def perform(player_id)
    player = Player.find(player_id)
    Player::SaveActivity.call(player)
  end
end
