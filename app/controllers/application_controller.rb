class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  protected

  def authenticate_user!
    authenticate_or_request_with_http_token do |token, _|
      current_user.present?
    end
  end

  def current_user
    @current_user ||= authenticate_with_http_token do |token, _|
      UserToken.authenticate(token)
    end
  end
end
