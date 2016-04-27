class Game::StartVersus
  def self.call(user_1, user_2)
    raise Givdo::Error, "You can't start a new game" unless user_1.can_create_game?
    user_1.create_game_versus!(user_2).tap do |game|
      Game::SendInvitation.call(user_2, game)
    end
  end
end
