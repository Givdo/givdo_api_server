class Trivia < ActiveRecord::Base
  has_many :options, :class_name => 'TriviaOption'
  has_many :answers, :through => :options

  def answer!(user, option_id)
    option = options.find(option_id)
    Answer.create(:option => option, :user => user)
  end
end
