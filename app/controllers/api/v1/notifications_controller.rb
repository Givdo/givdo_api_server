class Api::V1::NotificationsController < Api::V1::ApiController
  def index
    notifications = current_user.notifications.not_answered.unread
    notifications = notifications.page(page_number).per(page_size)

    render json: notifications
  end

  def update
    notification = current_user.notifications.find(params[:id])

    if notification.update_attributes(params.permit(:read, :status))
      render json: {}
    else
      render json: {}, status: :bad_request
    end
  end
end
