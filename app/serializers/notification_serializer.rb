class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :status

  belongs_to :sender, serializer: UserSerializer
end
