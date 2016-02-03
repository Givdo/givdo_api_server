require 'givdo/facebook'

class FriendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    render :json => Givdo::Facebook.invitable_friends(current_user, filter_params),
            :serializer => FriendsSerializer
  end

  private

  def filter_params
    params.permit(:page)
  end
end
