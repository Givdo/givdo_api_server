class Api::V1::ApiController < ApplicationController
  protect_from_forgery :with => :null_session
  before_filter :authenticate_token!

  rescue_from Givdo::TokenAuth::InvalidToken do
    head :status => :unauthorized
  end

  protected

  def current_user
    current_session.try(:user)
  end

  def authenticate_token!
    current_session.present? || request_http_token_authentication
  end

  def current_session
    @current_session ||= authenticate_with_http_token do |token, options|
      Givdo::TokenAuth.recover(token)
    end
  end
end
