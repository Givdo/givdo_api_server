require_dependency 'givdo/token_auth'

class ApplicationController < ActionController::Base
  protect_from_forgery :with => :null_session
  serialization_scope :current_user

  protected

  def current_user
    current_session.try(:user)
  end

  def authenticate_token!
    current_session.present? || request_http_token_authentication
  end

  def current_session
    @current_session ||= authenticate_with_http_token do |token, _|
      Givdo::TokenAuth.recover(token)
    end
  end

  private

  rescue_from Givdo::TokenAuth::InvalidToken do
    head :status => :unauthorized
  end
end
