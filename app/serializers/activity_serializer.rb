class ActivitySerializer < ActiveModel::Serializer
  attributes :name, :organization_name, :organization_picture

  def organization_name
    organization.name
  end

  def organization_picture
    organization.picture
  end

  private

  def organization
    object.subject.organization
  end
end
