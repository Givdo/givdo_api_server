class Game::StartSingle
  def self.call(user)
    return user.create_single_game! if user.can_create_game?
    raise Givdo::Error, "You can't start a new game"
  end
end
