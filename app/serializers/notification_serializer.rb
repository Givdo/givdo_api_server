class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :status, :category, :sender_name, :sender_image, :game_id


  def category
    object.game.try(:category).try(:name)
  end

  def sender_name
    object.try(:sender).try(:name)
  end

  def sender_image
    object.try(:sender).try(:image)
  end

  def game_id
    object.try(:game).try(:id)
  end
end
