class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :facebook_id, :name, :picture, :state, :city, :zip, :street, :mission
end
