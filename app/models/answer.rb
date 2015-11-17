# == Schema Information
#
# Table name: answers
#
#  user_id    :integer
#  option_id  :integer
#  updated_at :datetime         not null
#  correct    :boolean          default(FALSE), not null
#  id         :integer          not null, primary key
#
# Indexes
#
#  index_answers_on_option_id  (option_id)
#  index_answers_on_user_id    (user_id)
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :option, :class_name => 'TriviaOption'

  delegate :trivia, :trivia_id, :to => :option, :prefix => false, :allow_nil => true

  default_scope { includes(:option) }

  scope :from_past, -> (time_window) { where('updated_at > ?', time_window) }
end
