# == Schema Information
#
# Table name: answers
#
#  id               :integer          not null, primary key
#  trivia_option_id :integer
#  updated_at       :datetime         not null
#  correct          :boolean          default(FALSE), not null
#  trivia_id        :integer
#  player_id        :integer
#
# Indexes
#
#  index_answers_on_player_id         (player_id)
#  index_answers_on_trivia_option_id  (trivia_option_id)
#

class Answer < ActiveRecord::Base
  belongs_to :player
  belongs_to :trivia
  belongs_to :trivia_option
  has_one :game, :through => :player

  validates :trivia, :presence => true
  validates :trivia_option, :presence => true
  validates :player, :presence => true

  default_scope { includes(:trivia_option) }

  scope :from_past, -> (time_window) { where('updated_at > ?', time_window) }
  scope :correct, -> { where(:correct => true) }

  delegate :correct_option_id, :to => :trivia, :prefix => false, :allow_nil => true

  private

  before_save :review_answer
  def review_answer
    self.correct = trivia_option_id.eql?(trivia.correct_option_id)
    return true
  end

  after_save :update_player_score
  def update_player_score
    self.player.increment!(:score) if correct?
  end
end
