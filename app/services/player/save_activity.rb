class Player::SaveActivity
  def self.call(player)
    return unless player.finished?
    player.create_user_activity!
  end
end
