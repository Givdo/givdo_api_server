class Api::V1::NotificationsController < Api::V1::ApiController
  def index
    notifications = current_user.notifications.not_answered
    notifications = notifications.page(page_number).per(page_size)

    render json: notifications
  end

  def update
    notification = Notification.find(params[:id])
    notification.update_attribute(:status, params[:status])
    render json: notification, include: ['game.*']
  end
end
