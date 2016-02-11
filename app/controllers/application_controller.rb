class ApplicationController < ActionController::Base
  protect_from_forgery :with => :null_session
  rescue_from UserToken::InvalidToken, :with => :access_denied
  serialization_scope :current_user

  protected

  def authenticate_user!
    authenticate_or_request_with_http_token do |token, _|
      current_user.present? && BetaAccess.granted?(current_user)
    end
  end

  def current_user
    @current_user ||= authenticate_with_http_token do |token, _|
      UserToken.authenticate(token)
    end
  end

  private

  def access_denied
    head :status => :unauthorized
  end
end
