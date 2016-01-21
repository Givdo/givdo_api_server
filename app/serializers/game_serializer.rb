class GameSerializer < ActiveModel::Serializer
  has_one :player
  has_one :trivia

  link(:answers) { href Rails.application.routes.url_helpers.game_answers_url(object) }
  link(:player) do
    href Rails.application.routes.url_helpers.game_player_url(object)
  end

  def player
    object.player(scope)
  end

  def trivia
    @trivia ||= TriviaRaffle.next(scope, object)
  end
end
