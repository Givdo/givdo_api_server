class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :option, :class_name => 'TriviaOption'

  delegate :trivia, :trivia_id, :to => :option, :prefix => false

  default_scope { includes(:option) }

  scope :from_past, -> (time_window) { where('updated_at > ?', time_window) }
end
