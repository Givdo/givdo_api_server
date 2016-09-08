class FriendUserSerializer < ActiveModel::Serializer
  type 'users'

  attributes :name, :image, :cover, :uid, :provider

  has_many :badges
  has_many :causes
  belongs_to :organization
end
