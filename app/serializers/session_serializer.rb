class SessionSerializer < ActiveModel::Serializer
  has_one :user

  def id
    object.token
  end
end
