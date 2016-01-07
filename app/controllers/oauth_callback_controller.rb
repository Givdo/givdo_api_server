require 'givdo/oauth'

class OauthCallbackController < ApplicationController
  def facebook
    user = Givdo::OAuth::Facebook.validate!(params[:access_token])
    token = UserToken.generate(user, params[:expires_in].to_i)

    render :json => {:token => token}
  end
end
