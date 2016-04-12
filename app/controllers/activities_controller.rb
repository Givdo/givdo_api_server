class ActivitiesController < ApplicationController
  before_filter :authenticate_token!

  def index
    render json: Activity::Feed.new(current_user), include: ['activities']
  end
end
