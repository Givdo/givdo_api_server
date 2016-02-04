class FriendsSerializer < ActiveModel::Serializer
  type 'friends'

  link(:next) { href Rails.application.routes.url_helpers.friends_url(object.next_page_params) }

  has_many :users, :serializer => FriendUserSerializer

  def id
    scope.uid
  end

  def users
    object.users
  end
end
