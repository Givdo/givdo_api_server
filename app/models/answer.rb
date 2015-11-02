class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :option, :class_name => 'TriviaOption'
end
