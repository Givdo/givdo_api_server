require 'rails_helper'

RSpec.describe Api::V1::NotificationsController, type: :controller do
  let(:user) { create(:user) }
  let(:notification) { create(:notification, user: user, status: :not_answered) }

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
      expect(json['data'].size).to eq user.notifications.size
    end
  end

  describe "PUT #update" do
    it "responds with success" do
      api_user user

      put :update, id: notification.id, read: true

      expect(response.status).to eq(200)
    end

    it "updates the notification" do
      api_user user

      put :update, id: notification.id, read: true

      expect(notification.reload).to be_read
    end

    it 'does not allows change other fields than read and status' do
      time = 2.days.ago

      api_user user

      put :update, id: notification.id, created_at: time

      expect(notification.created_at).not_to eq time
    end
  end
end
