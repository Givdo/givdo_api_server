class Api::V1::UsersController < Api::V1::ApiController
  def show
    render :json => current_user, :serializer => UserSerializer,
      :include => ['organization', 'badges', 'causes']
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
