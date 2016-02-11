require 'givdo/oauth'

class OauthCallbackController < ApplicationController
  rescue_from Givdo::OAuth::Error, :with => :oauth_error

  def facebook
    user = Givdo::OAuth::Facebook.validate!(params[:access_token])
    if BetaAccess.granted?(user)
      token = UserToken.generate(user, params[:expires_in].to_i)

      render :json => {:token => token}
    else
      render :json => {:error => 'Beta access not granted', :code => :beta},
             :status => :unauthorized
    end
  end

  private

  def oauth_error(error)
    render :json => {:error => error.message, :code => :oauth},
           :status => :bad_request
  end
end
