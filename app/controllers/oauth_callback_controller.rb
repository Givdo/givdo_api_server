require 'givdo/oauth'

class OauthCallbackController < ApplicationController
  rescue_from Givdo::OAuth::Error, :with => :oauth_error

  def facebook
    user = Givdo::OAuth::Facebook.validate!(params[:access_token])
    token = UserToken.generate(user, params[:expires_in].to_i)

    render :json => {:token => token}
  end

  private

  def oauth_error(error)
    render :json => {:error => error.message}, :status => 400
  end
end
