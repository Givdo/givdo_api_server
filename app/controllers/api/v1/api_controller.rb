class Api::V1::ApiController < ApplicationController
  before_filter :authenticate_token!

  rescue_from Givdo::TokenAuth::InvalidToken do
    head :status => :unauthorized
  end

  protected

  def page_size
    params[:page].try(:[], :size) || 10
  end

  def page_number
    params[:page].try(:[], :number)
  end

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

  def render_exception(exception, status: :bad_request)
    render json: { errors: exception.errors }, status: status
  end
end
