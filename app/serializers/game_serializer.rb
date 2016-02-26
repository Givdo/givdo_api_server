class GameSerializer < ActiveModel::Serializer
  has_many :players
  has_one :player
  has_one :trivia

  link(:answers) { game_answers_url(object) }
  link(:player) { game_player_url(object) }

  def player
    @player ||= object.player(scope) if scope
  end

  def trivia
    @trivia ||= object.next_trivia(scope) if scope
  end
end
