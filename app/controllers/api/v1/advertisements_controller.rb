class AdvertisementsController < ApplicationController
  def show
    current_ad.impressions += 1
    render json: current_ad, serializer: AdvertisementSerializer
  end

  def click
    current_ad.clicks += 1
    redirect_to current_ad.link
  end

  private

  def current_ad
    @ad = Advertisement.find(params[:id])
  end
end