require 'acceptance_helper'

resource "Activities" do
  header "Accept", "application/vnd.api+json"
  header "Content-Type", "application/vnd.api+json"
  header "Authorization", :user_token

  let(:user) { create(:user) }
  let(:user_token) { "Token token=#{Givdo::TokenAuth::Session.new(user, '3600').token}" }

  get 'api/v1/activities' do
    example_request "Listing user's activity" do
      explanation "Returns user's acvitity feed."

      expect(status).to eq(200)
    end
  end
end
