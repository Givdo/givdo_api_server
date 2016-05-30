require 'acceptance_helper'

resource "Causes" do
  header "Authorization", :token

  let(:user) { create(:user) }
  let(:token) { "Token token=#{Givdo::TokenAuth::Session.new(user, '3600').token}" }

  get "api/v1/causes" do
    parameter :page, 'Object containing size and number'

    example_request "Listing causes" do
      expect(status).to eq(200)
    end
  end
end
