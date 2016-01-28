class PlayerSerializer < ActiveModel::Serializer
  attributes :rounds_left, :organization, :score, :finished?, :name, :image

  def name
    object.user.try(:name)
  end

  def image
    object.user.try(:image)
  end

  def organization
    object.organization.try(:name)
  end
end
