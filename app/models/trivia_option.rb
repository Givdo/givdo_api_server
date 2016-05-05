# == Schema Information
#
# Table name: trivia_options
#
#  id         :integer          not null, primary key
#  text       :string
#  trivia_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TriviaOption < ActiveRecord::Base
  belongs_to :trivia, inverse_of: :options

  has_many :answers, foreign_key: :option_id
end
