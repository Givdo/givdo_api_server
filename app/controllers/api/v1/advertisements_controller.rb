class Api::V1::AdvertisementsController < ApplicationController
  def index
    render json: Advertisement.active, each_serializer: AdvertisementSerializer
  end

  def record_impression
    current_advertisement.add_impression!
    render json: current_advertisement, serializer: AdvertisementSerializer
  end

  def record_click
    current_advertisement.add_click!
  end

  private

  def current_advertisement
    Advertisement.find_by(id: advertisement_params[:advertisement_id])
  end

  def advertisement_params
    params.permit(:user_id, :advertisement_id)
  end
end