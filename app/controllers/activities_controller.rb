class ActivitiesController < ApplicationController
  before_filter :authenticate_token!

  def index
    activities = current_user.recent_activities(10)
    total_score = activities.to_a.sum {|a| a.subject.score }
    
    render json: activities, meta: { total: total_score }
  end
end
