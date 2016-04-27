class Api::V1::DevicesController < Api::V1::ApiController
  def create
    device = current_user.devices.find_or_create_by(device_params)
    render json: device, status: :created
  end

  private

  def device_params
    params.permit(:token, :platform)
  end
end
