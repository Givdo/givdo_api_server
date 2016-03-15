require_dependency 'givdo/facebook'

class FriendsController < ApplicationController
  before_filter :authenticate_token!

  def index
    render :json => Givdo::Facebook.friends(current_user, filter_params),
            :serializer => FriendsSerializer, :include => 'users'
  end

  private

  def filter_params
    params.permit(:page)
  end
end
