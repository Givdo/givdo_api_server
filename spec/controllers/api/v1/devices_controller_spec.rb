require 'rails_helper'

RSpec.describe Api::V1::DevicesController, type: :controller do
  let(:user) { create(:user) }

  describe "on POST to /devices" do
    it "responds with status create" do
      api_user user

      post :create, { token: '12345', platform: 'iPobre' }

      expect(response).to have_http_status(:created)
    end

    it "adds a new device to the user" do
      api_user user

      post :create, { token: '12345', platform: 'iPobre' }

      expect(user.devices.last.token).to eq('12345')
    end

    it "renders devices details" do
      api_user user

      post :create, { token: '12345', platform: 'iPobre' }

      expect(json).to have_key('data')
      expect(json['data']).to have_key('type')
      expect(json['data']).to have_key('attributes')
    end
  end
end
