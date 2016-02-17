class GameSerializer < ActiveModel::Serializer
  has_many :players
  has_one :player
  has_one :trivia

  link(:answers) { game_answers_url(object) }
  link(:player) { game_player_url(object) }

  def player
    @player ||= object.player(scope)
  end

  def trivia
    @trivia ||= TriviaRaffle.next(player) if player
  end
end
