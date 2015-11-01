class TriviaOption < ActiveRecord::Base
  belongs_to :trivia, :inverse_of => :options
end
