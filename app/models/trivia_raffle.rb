class TriviaRaffle
  BACKFILL_TIME=1.hour

  def self.next(*args)
    new(*args).next
  end

  def initialize(user)
    @user = user
  end

  def next
    recent_answers = @user.answers.from_past(BACKFILL_TIME.ago)
    recent_trivias = recent_answers.map(&:trivia_id)

    Trivia.excluding(recent_trivias).first
  end
end
