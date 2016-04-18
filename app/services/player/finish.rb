class Player::Finish
  def self.call(player)
    player.tap do |player|
      player.finish!
      User::AssignBadges.call(player.user)
      Player::SaveActivity.call(player)
    end
  end
end
