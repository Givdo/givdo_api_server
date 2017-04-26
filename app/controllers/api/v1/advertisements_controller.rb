class AdvertisementsController < ApplicationController
  def show
    current_ad.add_impression!
    render json: current_ad, serializer: AdvertisementSerializer
  end

  def click
    current_ad.add_click!
    redirect_to current_ad.link
  end

  private

  def current_ad
    @ad = Advertisement.find(params[:id])
  end
end