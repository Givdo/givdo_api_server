require 'rails_helper'

RSpec.describe Api::V1::NotificationsController, type: :controller do
  let(:user) { create(:user) }
  let(:notification) { create(:notification, status: :not_answered) }

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

  describe "PUT #accept" do
    it "responds with success" do
      api_user user

      put :accept, id: notification.id

      expect(response.status).to eq(200)
    end

    it "updates notification's status" do
      api_user user

      put :accept, id: notification.id

      expect(notification.reload).to be_accepted
    end
  end

  describe "PUT #reject" do
    it "responds with success" do
      api_user user

      put :reject, id: notification.id

      expect(response.status).to eq(200)
    end

    it "updates notification's status" do
      api_user user

      put :reject, id: notification.id

      expect(notification.reload).to be_rejected
    end
  end
end
