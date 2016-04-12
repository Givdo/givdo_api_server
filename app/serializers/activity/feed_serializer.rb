class Activity::FeedSerializer < ActiveModel::Serializer
  attributes :total_score

  has_many :activities, class_name: Activity
end
