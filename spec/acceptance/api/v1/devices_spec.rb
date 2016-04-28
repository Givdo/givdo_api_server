require 'acceptance_helper'

resource "Devices" do
  header "Accept", "application/vnd.api+json"
  header "Content-Type", "application/vnd.api+json"
  header "Authorization", :user_token

  let(:user) { create(:user) }
  let(:user_token) { "Token token=#{Givdo::TokenAuth::Session.new(user, '3600').token}" }

  post "/api/v1/devices" do
    parameter :token, 'Registration ID', required: true
    parameter :platform, 'Platform name', required: true

    let(:token) { 'some-token' }
    let(:platform) { 'Android' }

    let(:raw_post) { params.to_json }

    example_request "Registering a device" do
      explanation "Registers a device to receive notifications from the server."

      expect(status).to eq(201)
    end
  end
end
