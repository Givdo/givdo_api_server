class AdvertisementSerializer < ActiveModel::Serializer
  attributes :company_name, :image_url, :link

  def image_url
    object.image_url
  end
end