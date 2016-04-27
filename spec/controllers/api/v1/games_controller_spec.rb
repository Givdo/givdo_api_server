require 'rails_helper'

RSpec.describe Api::V1::GamesController, :type => :controller do
  let(:game) { create(:game) }
  let(:user) { create(:user, :with_device) }

  before do
    app_name = 'test-app'
    Rpush::Gcm::App.create!(name: app_name, auth_key: 'foobar')
    allow(ENV).to receive(:[]).with('RPUSH_APP_NAME').and_return(app_name)
  end

  describe "on GET to /single" do
    it "starts a single game" do
      api_user user

      get :single

      expect(response).to have_http_status(:success)
      expect(user.owned_games).not_to be_empty
    end

    it "returns the game" do
      api_user user

      get :single

      expect(response).to have_http_status(:success)
      expect(json['data']['type']).to eq('games')
    end
  end

  describe "on GET /versus/:uid" do
    it "starts a versus game" do
      friend = create(:user, :with_device)
      allow(Givdo::Facebook).to receive(:friend).with(user, '12345').and_return(friend)

      api_user user
      get :versus, uid:'12345'

      expect(response).to have_http_status(:success)
      expect(user.owned_games).not_to be_empty
    end

    it "returns a game versus the friend" do
      friend = create(:user, :with_device)
      allow(Givdo::Facebook).to receive(:friend).with(user, '12345').and_return(friend)

      api_user user
      get :versus, uid:'12345'

      expect(response).to have_http_status(:success)
      expect(json['data']['type']).to eq('games')
    end
  end
end
