class PlayerSerializer < ActiveModel::Serializer
  attributes :rounds_left, :organization, :score, :finished?, :name

  def name
    object.user.try(:name)
  end

  def organization
    object.organization.try(:name)
  end
end
