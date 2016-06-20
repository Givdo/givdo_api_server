class Api::V1::NotificationsController < Api::V1::ApiController
  before_action :find_notification, only: [:accept, :reject]

  def index
    notifications = current_user.notifications.not_answered
    notifications = notifications.page(page_number).per(page_size)

    render json: notifications
  end

  def accept
    @notification.accept!
    render json: @notification.game
  end

  def reject
    @notification.reject!
    render json: @notificaion
  end

  private

  def find_notification
    @notification ||= Notification.find(params[:id])
  end
end
