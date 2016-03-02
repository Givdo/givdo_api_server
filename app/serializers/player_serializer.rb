class PlayerSerializer < ActiveModel::Serializer
  has_one :organization
  attributes :rounds_left, :score, :finished?, :name, :image, :winner?
  attribute :organization_name, :key => :organization

  def name
    object.user.try(:name)
  end

  def image
    object.user.try(:image)
  end

  def organization_name
    object.organization.try(:name)
  end
end
