class SessionSerializer < ActiveModel::Serializer
  has_one :user, :serializer => UserSerializer

  def id
    object.token
  end
end
