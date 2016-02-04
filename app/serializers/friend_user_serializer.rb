class FriendUserSerializer < ActiveModel::Serializer
  type 'users'

  attributes :name, :image, :uid, :provider
end
