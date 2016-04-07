# == Schema Information
#
# Table name: activities
#
#  id           :integer          not null, primary key
#  name         :string
#  subject_id   :integer
#  subject_type :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_activities_on_subject_type_and_subject_id  (subject_type,subject_id)
#  index_activities_on_user_id                      (user_id)
#

class Activity < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :user
end
