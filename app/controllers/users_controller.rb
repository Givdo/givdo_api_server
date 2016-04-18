class UsersController < ApplicationController
  before_filter :authenticate_token!

  def show
    render :json => current_user, :serializer => UserSerializer,
      :include => ['organization', 'badges']
  end

  def update
    current_user.update_attributes! user_params

    render :json => current_user, :serializer => UserSerializer,
      :include => ['organization', 'badges']
  end

  private

  def user_params
    params.permit(:organization_id)
  end
end
