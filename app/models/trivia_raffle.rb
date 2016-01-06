class TriviaRaffle
  def self.next(*args)
    new(*args).next
  end

  def initialize(user, game)
    @user, @game = user, game
  end

  def next
    return unless @game.has_rounds?(@user)

    played_trivias = @game.user_rounds(@user).pluck(:trivia_id)
    remaining_trivias = Trivia.excluding(played_trivias)

    rnd = rand(remaining_trivias.count)
    remaining_trivias.offset(rnd).first
  end
end
