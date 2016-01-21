class PlayerSerializer < ActiveModel::Serializer
  attributes :rounds_left, :organization

  def organization
    object.organization.try(:name)
  end
end
