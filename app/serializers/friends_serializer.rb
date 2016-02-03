class FriendsSerializer < ActiveModel::Serializer
  type 'friends'
  link(:next) { href Rails.application.routes.url_helpers.friends_url(object.next_page_params) }

  def id
    scope.uid
  end
end
