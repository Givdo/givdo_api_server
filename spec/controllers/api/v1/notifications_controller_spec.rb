require 'rails_helper'

RSpec.describe Api::V1::NotificationsController, type: :controller do
  let(:user) { create(:user) }
  let(:notification) { create(:notification, status: 'no_answer') }

  describe "GET #index" do
    it "responds with success" do
      api_user user

      get :index

      expect(response.status).to eq(200)
    end

    it "renders user's notifications" do
      api_user user

      get :index

      expect(json).to have_key('data')
      expect(json['data']).to be_an Array
    end
  end

  describe "PUT #update" do
    it "responds with success" do
      api_user user

      put :update, id: notification.id, status: 'rejected'

      expect(response.status).to eq(200)
    end

    it "updates notification's status" do
      api_user user

      put :update, id: notification.id, status: 'accepted'

      expect(notification.reload).to be_accepted
    end
  end
end
