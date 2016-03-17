class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :cover, :email
  has_one :organization

  link(:self) { user_url(object) }
end
