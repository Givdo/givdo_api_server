require 'rails_helper'

RSpec.describe Api::V1::ApiController, :type => :controller do
  let(:user) { create(:user) }
  let(:token) { Givdo::TokenAuth::Session.new(user, '3600').token }

  controller do
    def index
      render :text => 'you are in'
    end
  end

  context "when a valid token is present" do
    before do
      @request.env['HTTP_AUTHORIZATION'] = "Token token=#{token}"
    end

    it "responds with status ok" do
      get :index

      expect(response.status).to eq(200)
    end

    it "loads a session for token owner" do
      get :index

      session = assigns(:current_session)

      expect(session.user).to eq(user)
    end
  end

  context "when token isn't present" do
    it "responds with status unauthorized" do
      get :index

      expect(response.status).to eq(401)
    end
  end
end
