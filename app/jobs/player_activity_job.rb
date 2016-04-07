class PlayerActivityJob < ActiveJob::Base
  queue_as :urgent

  def perform(player_id)

  end
end
