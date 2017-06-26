require 'rails_helper'

RSpec.describe Api::V1::ActivitiesController, type: :controller do
  let(:user) { create(:user_with_activities, activities_count: 20) }

  before do
    api_user user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index

      expect(response).to have_http_status(:success)
    end

    it "returns 10 most recent activities for the current user" do
      get :index

      activities = json['data']['relationships']['activities']['data']

      expect(activities.size).to eq(10)
    end

    it "returns the total score for the current user" do
      total = user.total_score

      get :index

      expect(json['data']['attributes']['totalScore']).to eq(total)
    end
  end
end
