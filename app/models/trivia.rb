# == Schema Information
#
# Table name: trivia
#
#  id                :integer          not null, primary key
#  question          :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  correct_option_id :integer
#

class Trivia < ActiveRecord::Base
  has_many :options, :class_name => 'TriviaOption'
  has_many :answers, :through => :options

  scope :excluding, -> (trivias) { where.not(id: trivias) }

  def answer!(user, option_id)
    option = options.find(option_id)
    correctness = correct_option_id.eql?(option_id)
    Answer.create(:option => option, :user => user, :correct => correctness)
  end
end
