class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :cover, :email, :total_score

  has_many :badges
  has_many :causes
  has_one :organization

  link(:self) { api_v1_user_url(object) }
end
