class TriviaRaffle < Struct.new(:game, :limit)
  def self.raffle(*args)
    new(*args).raffle
  end

  def raffle
    current_trivias = game.trivias.map(&:id)
    remaining_trivias = Trivia.excluding(current_trivias)
    rnd = rand(remaining_trivias.count - limit)
    remaining_trivias.offset(rnd).limit(limit)
  end
end
