require 'acceptance_helper'

resource "Notifications" do
  header "Authorization", :token

  let(:user) { create(:user) }
  let(:token) { "Token token=#{Givdo::TokenAuth::Session.new(user, '3600').token}" }

  get "/api/v1/notifications" do
    example_request "Listing user's notifications" do
      expect(status).to eq(200)
    end
  end
end
