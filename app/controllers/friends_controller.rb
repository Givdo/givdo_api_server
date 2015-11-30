require_dependency 'givdo/facebook'

class FriendsController < ApplicationController
  before_filter :authenticate_user!

  FRIENDS_PER_PAGE = 100

  def index
    render json: Givdo::Facebook.invitable_friends(current_user, friends_list_params),
           serializer: FriendsListSerializer
  end

  private

  def friends_list_params
    params.merge(limit: FRIENDS_PER_PAGE)
  end
end
