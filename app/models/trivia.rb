class Trivia < ActiveRecord::Base
  has_many :options, :class_name => 'TriviaOption'
  has_many :answers, :through => :options

  def answer!(user, option_id)
    option = options.find(option_id)
    correctness = correct_option_id.eql?(option_id)
    Answer.create(:option => option, :user => user, :correct => correctness)
  end
end
