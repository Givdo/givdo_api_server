class Game::StartVersus
  def self.call(player_1, player_2)
    return player_1.create_game_versus!(player_2) if player_1.can_create_game?
    raise Givdo::Error, "You can't start a new game"
  end
end
