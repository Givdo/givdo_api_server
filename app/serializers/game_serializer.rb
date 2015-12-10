class GameSerializer < ActiveModel::Serializer
  attributes :id
  has_one :creator
end
