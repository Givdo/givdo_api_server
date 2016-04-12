class Activity::Feed
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :id, :user, :feed_size, :activities, :total_score

  def initialize(user, params = {})
    params.store(:total_score, user.total_score)
    params.store(:activities, user.recent_activities(10))

    super(params)
  end
end
