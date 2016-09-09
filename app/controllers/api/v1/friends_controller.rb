class Api::V1::FriendsController < Api::V1::ApiController
  def index
    render :json => Givdo::Facebook.friends(current_user, filter_params),
           :serializer => FriendsSerializer, :include => 'users'
  end

  def show
    render :json => User.find(params[:id]),
           serializer: FriendUserSerializer,
           include: ['badges,causes,organization']
  end

  private

  def filter_params
    params.permit(:page)
  end
end
