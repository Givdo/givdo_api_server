class Api::V1::NotificationsController < Api::V1::ApiController
  def index
    render json: current_user.notifications.page(page_number).per(page_size)
  end

  def update
    notification = Notification.find(params[:id])
    notification.update_attribute(:status, params[:status])
    render json: notification, include: %w[game]
  end
end
