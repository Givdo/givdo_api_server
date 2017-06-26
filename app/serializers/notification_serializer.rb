class NotificationSerializer < ApplicationSerializer
  attributes :id, :status, :category, :sender_name, :sender_image,
    :accept_url, :reject_url, :read_url

  belongs_to :game
  belongs_to :sender

  def category
    object.game.try(:category).try(:name)
  end

  def sender_name
    object.try(:sender).try(:name)
  end

  def sender_image
    object.try(:sender).try(:image)
  end

  def read_url
    api_v1_notification_url(object, read: true)
  end

  def accept_url
    '#'
  end

  def reject_url
    api_v1_notification_url(object, status: Notification.statuses[:rejected])
  end
end
