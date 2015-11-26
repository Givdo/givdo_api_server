require_dependency 'givdo/facebook'

class FriendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    render json: Givdo::Facebook.invitable_friends(current_user, params),
           serializer: FriendsListSerializer
  end
end
