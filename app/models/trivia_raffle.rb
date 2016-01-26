class TriviaRaffle
  def self.next(*args)
    new(*args).next
  end

  def initialize(player)
    @player = player
  end

  def next
    return unless @player.has_rounds?

    played_trivias = @player.answers.pluck(:trivia_id)
    remaining_trivias = Trivia.excluding(played_trivias)

    rnd = rand(remaining_trivias.count)
    remaining_trivias.offset(rnd).first
  end
end
