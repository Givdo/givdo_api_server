class AnswerSerializer < ActiveModel::Serializer
  attributes :correct, :correct_option_id

  has_one :player
  has_one :game
end
