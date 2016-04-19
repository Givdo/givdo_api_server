class Api::V1::ActivitiesController < Api::V1::ApiController
  def index
    render json: Activity::Feed.new(current_user), include: ['activities']
  end
end
