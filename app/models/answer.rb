# == Schema Information
#
# Table name: answers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  option_id  :integer
#  updated_at :datetime         not null
#  correct    :boolean          default(FALSE), not null
#  trivia_id  :integer
#  game_id    :integer
#
# Indexes
#
#  index_answers_on_option_id  (option_id)
#  index_answers_on_user_id    (user_id)
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  belongs_to :trivia
  belongs_to :option, :class_name => 'TriviaOption'

  validates :trivia, :presence => true
  validates :game,   :presence => true
  validates :option, :presence => true
  validates :user,   :presence => true

  default_scope { includes(:option) }

  scope :from_past, -> (time_window) { where('updated_at > ?', time_window) }

  delegate :correct_option_id, :to => :trivia, :prefix => false, :allow_nil => true

  private

  before_save :review_answer

  def review_answer
    self.correct = option_id.eql?(trivia.correct_option_id)
    return true
  end
end
