# == Schema Information
#
# Table name: trivia
#
#  id                :integer          not null, primary key
#  question          :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  correct_option_id :integer
#  category_id       :integer
#

class Trivia < ActiveRecord::Base
  belongs_to :category
  belongs_to :correct_option, class_name: 'TriviaOption'

  has_many :options, class_name: 'TriviaOption', dependent: :delete_all
  has_many :answers, :through => :options

  scope :excluding, -> (trivias) { where.not(id: trivias) }
  scope :category, -> (category) { where(category: category) }

  accepts_nested_attributes_for :options

  def new_option(attrs)
    TriviaOption.new(attrs.merge(trivia: self))
  end

  def new_correct_option(attrs)
    self.correct_option = new_option(attrs)
  end
end
