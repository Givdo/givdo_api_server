class Api::V1::CausesController < Api::V1::ApiController
  def index
    current_page = causes.page(page_number).per(page_size)
    render json: current_page
  end

  def create
    current_user.causes = Cause.find(params[:id])
    render json: current_user.causes, status: :created
  rescue ActiveRecord::ActiveRecordError
    render json: {}, status: :not_found
  end

  private

  def causes
    return Cause.ransack(params[:search]).result if params[:search].present?
    Cause
  end

  def page_size
    params[:page].try(:[], :size) || 20
  end

  def page_number
    params[:page].try(:[], :number)
  end
end
