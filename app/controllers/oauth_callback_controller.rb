require 'givdo/oauth'
require 'givdo/token_auth'

class OauthCallbackController < ApplicationController
  rescue_from Givdo::OAuth::Error, :with => :oauth_error

  def facebook
    user = Givdo::OAuth::Facebook.validate!(params[:access_token])
    if BetaAccess.granted?(user)
      render :json => Givdo::TokenAuth::Session.new(user, params[:expires_in]),
             :serializer => SessionSerializer
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
