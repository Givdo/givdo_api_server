class Trivia < ActiveRecord::Base
  has_many :options, class_name: 'TriviaOption'
end
