class OauthCallbackController < ApplicationController
  def callback
    user = User.for_provider(params[:provider],  params[:uid], params[:access_token])
    token = UserToken.generate(user, params[:expires_in].to_i)

    render :json => {:token => token}
  end
end
