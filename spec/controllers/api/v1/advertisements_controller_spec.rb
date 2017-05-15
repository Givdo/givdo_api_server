require 'rails_helper'

RSpec.describe Api::V1::AdvertisementsController, type: :controller do
  let(:user) { create(:user) }

  let!(:advertisement_1) { create(:advertisement, active: true) }
  let!(:advertisement_2) { create(:advertisement, active: false) }
  let!(:advertisement_3) { create(:advertisement, active: true) }


  before do
    api_user user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index

      expect(response).to have_http_status(:success)
    end

    it "returns active ads" do
      get :index
      ads = json['data']

      expect(ads.size).to eq(2)
    end

  end
end
