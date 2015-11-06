class AnswerSerializer < ActiveModel::Serializer
  attributes :correct, :correct_option_id

  private

  def correct_option_id
    object.trivia.try(:correct_option_id)
  end
end
