require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:test_ad) { create(:advertisement, image_file_name: 'test_image.jpg')}

  describe 'image_url' do
    it 'has an image url' do
      expect(test_ad.image_url).to include('test_image.jpg')
    end
  end

end
