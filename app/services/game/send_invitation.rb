class Game::SendInvitation
  def self.call(user, game)
    Notification.create!(game: game, user: user, sender: game.creator)
  end
end
