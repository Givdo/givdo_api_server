class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :cover, :email, :total_score

  has_one :organization

  link(:self) { user_url(object) }
end
