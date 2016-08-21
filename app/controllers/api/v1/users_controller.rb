class Api::V1::UsersController < Api::V1::ApiController
  def show
    new_session = Givdo::TokenAuth::Session.new(current_user, 14.days.seconds)

    render :json => new_session, :serializer => SessionSerializer, include: 'user.*'
      #:include => ['organization', 'badges', 'causes']
  end

  def update
    current_user.update_attributes! user_params

    render :json => current_user, :serializer => UserSerializer,
      :include => ['organization', 'badges', 'causes']
  end

  private

  def user_params
    params.permit(:organization_id)
  end
end
