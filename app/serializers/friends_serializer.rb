class FriendsSerializer < ActiveModel::Serializer
  type 'friends'

  link(:next) { friends_url(object.next_page_params) }

  has_many :users, :serializer => FriendUserSerializer

  def id
    scope.uid
  end

  def users
    object.users
  end
end
