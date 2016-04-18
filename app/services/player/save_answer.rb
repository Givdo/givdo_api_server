class Player::SaveAnswer
  def self.call(player, params)
    player.answer!(params).tap do |answer|
      Player::Finish.call(player) unless player.has_rounds?
    end
  end
end
