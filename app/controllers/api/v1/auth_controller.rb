class Api::V1::AuthController < Api::V1::ApiController
  skip_before_filter :authenticate_token!

  rescue_from Givdo::Oauth::Error do |error|
    render :json => {:error => error.message, :code => :oauth},
           :status => :bad_request
  end

  def facebook
    user = Givdo::Oauth::Facebook.validate!(params[:access_token])

    render :json => Givdo::TokenAuth::Session.new(user, params[:expires_in]),
             :serializer => SessionSerializer, :include => 'user.*'
  end
end
