class PlayerSerializer < ActiveModel::Serializer
  attributes :rounds_left, :organization, :score

  def organization
    object.organization.try(:name)
  end
end
