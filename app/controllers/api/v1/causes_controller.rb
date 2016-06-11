class Api::V1::CausesController < Api::V1::ApiController
  def index
    current_page = causes.page(page_number).per(page_size)
    render json: current_page
  end

  def create
    causes = Cause.find(params[:id] - current_user.causes.pluck(:id))
    current_user.causes << causes
    render json: causes, status: :created
  rescue ActiveRecord::ActiveRecordError
    render json: {}, status: :not_found
  end

  private

  def causes
    return Cause.ransack(params[:search]).result if params[:search].present?
    Cause
  end

  def page_size
    params[:page].try(:[], :size) || 10
  end

  def page_number
    params[:page].try(:[], :number)
  end
end
