class PlayerSerializer < ActiveModel::Serializer
  attributes :rounds_left, :organization

  def rounds_left
    object.game.rounds_left(object.user)
  end

  def organization
    object.organization.try(:name)
  end
end

class GameSerializer < ActiveModel::Serializer
  attributes :id
  has_one :player

  def player
    object.player(scope)
  end
end
