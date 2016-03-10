class TriviaRaffle < Struct.new(:game, :limit)
  def self.raffle(*args)
    new(*args).raffle
  end

  def raffle
    current_trivias = game.trivias.map(&:id)
    raffle_among scope.excluding(current_trivias)
  end

  private

  def raffle_among(scope)
    rnd = rand(scope.count - limit)
    scope.offset(rnd).limit(limit)
  end

  def scope
    Trivia.category(game.category)
  end
end
