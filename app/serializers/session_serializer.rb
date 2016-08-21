class SessionSerializer < ActiveModel::Serializer
  attributes :token, :exp_in

  has_one :user, :serializer => UserSerializer

  def id
    object.token
  end

  def exp_in
    object.exp
  end

  alias_method :token, :id
end
